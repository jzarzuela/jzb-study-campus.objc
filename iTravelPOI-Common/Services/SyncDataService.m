//
// SyncDataService.m
// iTravelPOI-FRWK
//
// Created by Jose Zarzuela on 29/08/12.
// Copyright (c) 2012 Jose Zarzuela. All rights reserved.
//
#define __MBaseEntity__SYNCHRONIZATION__PROTECTED__

#import "SyncDataService.h"
#import "GMapSyncService.h"
#import "GMTItem.h"
#import "GMTMap.h"
#import "GMTPoint.h"
#import "MMap.h"
#import "MPoint.h"
#import "GMTCompTuple.h"



// *********************************************************************************************************************
#pragma mark -
#pragma mark Service private enumerations & definitions
// ---------------------------------------------------------------------------------------------------------------------



// *********************************************************************************************************************
#pragma mark -
#pragma mark SyncDataService Service private interface definition
// ---------------------------------------------------------------------------------------------------------------------
@interface SyncDataService () <GMPSyncDelegate>

@property (nonatomic, strong) NSManagedObjectContext *moContext;
@property (nonatomic, assign) id<PSyncDataDelegate> delegate;
@property (nonatomic, strong) GMapSyncService *syncSrvc;
@property (nonatomic, strong) dispatch_queue_t delegateQueue;

@end



// *********************************************************************************************************************
#pragma mark -
#pragma mark SyncDataService Service implementation
// ---------------------------------------------------------------------------------------------------------------------
@implementation SyncDataService



// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark CLASS public methods
// ---------------------------------------------------------------------------------------------------------------------
+ (SyncDataService *) syncDataServiceWithMOContext:(NSManagedObjectContext *)moContext delegate:(id<PSyncDataDelegate>)delegate {

    SyncDataService *me = [[SyncDataService alloc] init];
    me.moContext = moContext;
    me.delegate = delegate;
    me.delegateQueue = dispatch_get_current_queue();
    
    return me;
}

// ---------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [self cancelSync];
}




// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark public INSTANCE methods
// ---------------------------------------------------------------------------------------------------------------------
- (void) startMapsSync {
    
    
    __block BOOL allOK = true;
    
    [self.moContext performBlock:^{
        
        DDLogVerbose(@"****** START: excuteTest ******");
        
        
        NSError *error;
        
        self.syncSrvc = [GMapSyncService serviceWithEmail:@"jzarzuela@gmail.com" password:@"#webweb1971" delegate:self error:&error];
        if(!self.syncSrvc) {
            allOK = false;
            DDLogError(@"Error en sincronizacion(login) %@", error);
        }
        
        if(![self.syncSrvc syncMaps:&error]) {
            allOK = false;
            DDLogError(@"Error en sincronizacion %@", error);
        }
        
        DDLogVerbose(@"****** END: excuteTest ******");
        dispatch_async(dispatch_get_main_queue(), ^{
            if(allOK) {
                [self cleanDeletedMaps];
            }
            [self.delegate syncFinished:allOK];
        });
    }];
}

// ---------------------------------------------------------------------------------------------------------------------
- (void) cancelSync {
    [self.syncSrvc cancelSync];
    self.syncSrvc = nil;
}


// =====================================================================================================================
#pragma mark -
#pragma mark <GMPSyncDelegate> protocol methods
// ---------------------------------------------------------------------------------------------------------------------
- (NSArray *) getAllLocalMapList:(NSError **)err {
    
    if(err != nil) *err = nil;
    NSArray *allMaps = [MMap allMapsInContext:self.moContext includeMarkedAsDeleted:true];
    return allMaps;
}

// ---------------------------------------------------------------------------------------------------------------------
- (GMTMap *) gmMapFromLocalMap:(MMap *)localMap error:(NSError **)err {
    
    if(err != nil) *err = nil;
    
    GMTMap *gmMap = [GMTMap emptyMap];
    
    gmMap.name = localMap.name;
    gmMap.gmID = localMap.gID;
    gmMap.etag = localMap.etag;
    gmMap.published_Date = localMap.creationTime;
    gmMap.updated_Date = localMap.updateTime;
    gmMap.summary = localMap.summary;
    
    return gmMap;
}

// ---------------------------------------------------------------------------------------------------------------------
- (id) createLocalMapFrom:(GMTMap *)gmMap error:(NSError **)err {
    
    if(err != nil) *err = nil;
    
    MMap *localMap = [MMap emptyMapWithName:gmMap.name inContext:self.moContext];
    [self updateLocalMap:localMap withRemoteMap:gmMap allPointsOK:true error:err];
    
    return localMap;
}

// ---------------------------------------------------------------------------------------------------------------------
- (BOOL) updateLocalMap:(MMap *)localMap withRemoteMap:(GMTMap *)gmMap allPointsOK:(BOOL)allPointsOK error:(NSError **)err {
    
    if(err != nil) *err = nil;
    if(!gmMap) {
        return false;
    }
    
    [localMap _updateBasicInfoWithGID:gmMap.gmID etag:gmMap.etag creationTime:gmMap.published_Date updateTime:gmMap.updated_Date];
    localMap.name = gmMap.name;
    localMap.summary = gmMap.summary;
    [localMap markAsDeleted:FALSE];
    [localMap _cleanMarkAsModified];
    
    return true;
}

// ---------------------------------------------------------------------------------------------------------------------
- (BOOL) deleteLocalMap:(MMap *)localMap error:(NSError **)err {
    
    if(err != nil) *err = nil;
    
    [localMap markAsDeleted:true];
    [localMap _cleanMarkAsModified];
    
    return true;
}

// ---------------------------------------------------------------------------------------------------------------------
- (NSArray *) localPointListForMap:(MMap *)localMap error:(NSError **)err {
    
    if(err != nil) *err = nil;
    
    NSArray *pointList = localMap.points.allObjects;
    return pointList;
}

// ---------------------------------------------------------------------------------------------------------------------
- (GMTPoint *) gmPointFromLocalPoint:(MPoint *)localPoint error:(NSError **)err {
    
    if(err != nil) *err = nil;
    
    GMTPoint *gmPoint = [GMTPoint emptyPoint];
    
    gmPoint.name = localPoint.name;
    gmPoint.gmID = localPoint.gID;
    gmPoint.etag = localPoint.etag;
    gmPoint.published_Date = localPoint.creationTime;
    gmPoint.updated_Date = localPoint.updateTime;
    
    gmPoint.descr = localPoint.descr;
    gmPoint.iconHREF = localPoint.iconHREF;
    gmPoint.latitude = localPoint.latitudeValue;
    gmPoint.longitude = localPoint.longitudeValue;
    
    
    /**************************************************************************************************/
    //@TODO: Hay que conseguir la informacion de las categorias de algun sitio del punto
    @throw [NSException exceptionWithName:@"TODO_Exception" reason:@"Hay que extraer la informacion de las categorias" userInfo:nil];
    /**************************************************************************************************/

    return gmPoint;
}

// ---------------------------------------------------------------------------------------------------------------------
- (id) createLocalPointFrom:(GMTPoint *)gmPoint inLocalMap:(MMap *)map error:(NSError **)err {
    
    if(err != nil) *err = nil;
    
    MPoint *localPoint = [MPoint emptyPointWithName:gmPoint.name inMap:map];
    [self updateLocalPoint:localPoint withRemotePoint:gmPoint error:err];
    
    return localPoint;
}

// ---------------------------------------------------------------------------------------------------------------------
- (BOOL) updateLocalPoint:(MPoint *)localPoint withRemotePoint:(GMTPoint *)gmPoint error:(NSError **)err {
    
    if(err != nil) *err = nil;
    if(!gmPoint) {
        return false;
    }
    
    [localPoint _updateBasicInfoWithGID:gmPoint.gmID etag:gmPoint.etag creationTime:gmPoint.published_Date updateTime:gmPoint.updated_Date];
    localPoint.name = gmPoint.name;
    localPoint.descr = gmPoint.descr;
    localPoint.iconHREF = gmPoint.iconHREF;
    [localPoint setLatitude:gmPoint.latitude longitude:gmPoint.longitude];
    
    
    /**************************************************************************************************/
    //@TODO: Hay que conseguir la informacion de las categorias de algun sitio del punto
    @throw [NSException exceptionWithName:@"TODO_Exception" reason:@"Hay que extraer la informacion de las categorias" userInfo:nil];
    /**************************************************************************************************/

    
    [localPoint markAsDeleted:FALSE];
    [localPoint _cleanMarkAsModified];
    
    return true;
}

// ---------------------------------------------------------------------------------------------------------------------
- (BOOL) deleteLocalPoint:(MPoint *)localPoint inLocalMap:(id)map error:(NSError **)err {
    
    if(err != nil) *err = nil;
    
    [localPoint markAsDeleted:TRUE];
    [localPoint _cleanMarkAsModified];
    
    return true;
}


// =====================================================================================================================
#pragma mark -
#pragma mark OPTIONAL <GMPSyncDelegate> protocol methods
// ---------------------------------------------------------------------------------------------------------------------
- (void) willGetRemoteMapList {
    dispatch_async(self.delegateQueue, ^{
        [self.delegate willGetRemoteMapList];
    });
}

// ---------------------------------------------------------------------------------------------------------------------
- (void) didGetRemoteMapList {
    dispatch_async(self.delegateQueue, ^{
        [self.delegate didGetRemoteMapList];
    });
}

// ---------------------------------------------------------------------------------------------------------------------
- (void) willSyncMapTupleList:(NSArray *)_compTuples {
    
    __block NSArray *compTuples = _compTuples;
    dispatch_async(self.delegateQueue, ^{
        [self.delegate willSyncMapTupleList:compTuples];
    });
}

// ---------------------------------------------------------------------------------------------------------------------
- (void) willSyncMapTuple:(GMTCompTuple *)t_tuple withIndex:(int) t_index {

    __block GMTCompTuple *tuple = t_tuple;
    __block int index = t_index;
    
    if(index>=0) {
        dispatch_async(self.delegateQueue, ^{
            [self.delegate willSyncMapTuple:tuple withIndex:index];
        });
    }
}

// ---------------------------------------------------------------------------------------------------------------------
- (void) didSyncMapTuple:(GMTCompTuple *)t_tuple withIndex:(int) t_index syncOK:(BOOL)t_syncOK {
    
    __block GMTCompTuple *tuple = t_tuple;
    __block int index = t_index;
    __block BOOL syncOK = t_syncOK;
    
    if(index>=0) {
        dispatch_async(self.delegateQueue, ^{
            [self.delegate didSyncMapTuple:tuple withIndex:index syncOK:syncOK];
        });
    }
}


// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Getter & Setter methods
// ---------------------------------------------------------------------------------------------------------------------


// ---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Private methods
// ---------------------------------------------------------------------------------------------------------------------
- (void) cleanDeletedMaps {
    
    NSArray *allMaps = [MMap allMapsInContext:self.moContext includeMarkedAsDeleted:true];
    for(MMap *map in allMaps) {
        if(map.markedAsDeletedValue) {
            [map.managedObjectContext deleteObject:map];
        }
    }
}

@end

