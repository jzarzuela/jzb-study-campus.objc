//
//  ModelService.h
//  CDTest
//
//  Created by Snow Leopard User on 03/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService-Protected.h"

#import "MEBaseEntity.h"
#import "MEMap.h"
#import "MEBaseEntity.h"
#import "MECategory.h"
#import "MEPoint.h"


//*********************************************************************************************************************
#pragma mark -
#pragma mark Enumeration & definitions
//---------------------------------------------------------------------------------------------------------------------

typedef void (^TBlock_getUserMapListFinished)(NSArray *maps, NSError *error);
typedef void (^TBlock_getElementListInMapFinished)(NSArray *elements, NSError *error);



//*********************************************************************************************************************
#pragma mark -
#pragma mark ModelService interface definition
//---------------------------------------------------------------------------------------------------------------------
@interface ModelService : BaseService



//---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark ModelService CLASS public methods
//---------------------------------------------------------------------------------------------------------------------
+ (ModelService *)sharedInstance;



//---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark ModelService INSTANCE public methods
//---------------------------------------------------------------------------------------------------------------------

// persiste y elimina el mapa indicado
- (NSError *) storeMap:(MEMap *)map;
- (NSError *) removeMap:(MEMap *)map;

// Carga la informacion de los puntos si no lo habia hecho ya
- (NSError *) loadMapData:(MEMap *)map;

// Asynchronous methods
- (SRVC_ASYNCHRONOUS) asyncGetUserMapList:(TBlock_getUserMapListFinished) callbackBlock;
- (SRVC_ASYNCHRONOUS) asyncGetFlatElemensInMap:(MEMap *)map forCategories:(NSArray *)categories callback:(TBlock_getElementListInMapFinished) callbackBlock;
- (SRVC_ASYNCHRONOUS) asyncGetCategorizedElemensInMap:(MEMap *)map forCategories:(NSArray *)categories callback:(TBlock_getElementListInMapFinished) callbackBlock;

// Synchrouns methods
- (NSArray *) getUserMapList:(NSError * __autoreleasing *)error;
- (NSArray *) getFlatElemensInMap:(MEMap *)map forCategories:(NSArray *)categories error:(NSError * __autoreleasing *)error ;
- (NSArray *) getCategorizedElemensInMap:(MEMap *)map forCategories:(NSArray *)categories error:(NSError * __autoreleasing *)error;


@end
