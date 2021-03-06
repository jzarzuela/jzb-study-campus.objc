//
//  MPoint.m
//

#define __MPoint__IMPL__
#define __MPoint__PROTECTED__
#define __MMapBaseEntity__SUBCLASSES__PROTECTED__

#import "MPoint.h"
#import "MMap.h"
#import "MCategory.h"
#import "MMapThumbnail.h"
#import "ImageManager.h"
#import "ErrorManagerService.h"



//*********************************************************************************************************************
#pragma mark -
#pragma mark Private Enumerations & definitions
//*********************************************************************************************************************
#define UPD_POINT_ADDED   +1
#define UPD_POINT_REMOVED -1
#define DEFAULT_POINT_ICON_HREF @"http://maps.gstatic.com/mapfiles/ms2/micons/blue-dot.png"




//*********************************************************************************************************************
#pragma mark -
#pragma mark PRIVATE interface definition
//*********************************************************************************************************************
@interface MPoint ()

@end



//*********************************************************************************************************************
#pragma mark -
#pragma mark Implementation
//*********************************************************************************************************************
@implementation MPoint



//=====================================================================================================================
#pragma mark -
#pragma mark CLASS methods
//---------------------------------------------------------------------------------------------------------------------
+ (MPoint *) emptyPointWithName:(NSString *)name inMap:(MMap *)map withCategory:(MCategory *)category {
    
    NSManagedObjectContext *moContext = map.managedObjectContext;
    
    
    MPoint *point = [MPoint insertInManagedObjectContext:moContext];
    point.thumbnail = [MMapThumbnail insertInManagedObjectContext:moContext];
    
    [point _resetEntityWithName:name];
    
    point.map = map;
    
    if(category!=nil) {
        point.category = (MCategory *)[moContext objectWithID:category.objectID];
    } else {
        point.category = [MCategory categoryForIconHREF:DEFAULT_POINT_ICON_HREF inContext:moContext];
    }
    
    [point.map updateViewCount: UPD_POINT_ADDED];
    [point.category updateViewCount: UPD_POINT_ADDED];
    [point.category updateViewCountForMap:map increment:UPD_POINT_ADDED];
    
    
    return point;
}

// ---------------------------------------------------------------------------------------------------------------------
+ (NSArray *) pointsInMap:(MMap *)map category:(MCategory *)cat {
        
    // Crea la peticion de busqueda
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MPoint"];
    
    
    // Se asigna una condicion de filtro
    NSPredicate *query = [NSPredicate predicateWithFormat:@"markedAsDeleted=NO AND map=%@ AND category=%@", map, cat];
    [request setPredicate:query];
    
    // Se asigna el criterio de ordenacion
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:TRUE];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:sortDescriptors];
    
    // Se ejecuta y retorna el resultado
    NSError *localError = nil;
    NSArray *array = [map.managedObjectContext executeFetchRequest:request error:&localError];
    if(array==nil) {
        [ErrorManagerService manageError:localError compID:@"MPoint:pointsInMap" messageWithFormat:@"Error fetching points in map '%@' with category '%@'-'%@'", map.name, cat.iconBaseHREF, cat.fullName];
    }
    return array;
}


//=====================================================================================================================
#pragma mark -
#pragma mark Getter & Setter methods
//---------------------------------------------------------------------------------------------------------------------
- (MAP_ENTITY_TYPE) entityType {
    return MET_POINT;
}

//---------------------------------------------------------------------------------------------------------------------
- (JZImage *) entityImage {
    return [ImageManager iconDataForHREF:self.category.iconBaseHREF].image;
}




//=====================================================================================================================
#pragma mark -
#pragma mark Public methods
//---------------------------------------------------------------------------------------------------------------------
- (void) updateDeleteMark:(BOOL) value {
    
    // Si ya es igual no hace nada
    if(self.markedAsDeletedValue==value) return;
    
    // Ajusta la cuenta de puntos visibles en su mapa y categoria
    int increment = value ? UPD_POINT_REMOVED : UPD_POINT_ADDED;
    [self.map updateViewCount:increment];
    [self.category updateViewCount: increment];
    [self.category updateViewCountForMap:self.map increment:increment];
    
    // Establece el nuevo valor llamando a su clase base
    [super _baseUpdateDeleteMark:value];
}

//---------------------------------------------------------------------------------------------------------------------
- (void) moveToCategory:(MCategory *)category {
    
    // Si ya es igual no hace nada
    if([self.category.objectID isEqual:category.objectID]) return;
    
    //
    self.modifiedSinceLastSyncValue = true;

    
    // Descuenta de la actual si no estaba marcado como borrado
    if(!self.markedAsDeletedValue) {
        [self.category updateViewCount: UPD_POINT_REMOVED];
        [self.category updateViewCountForMap:self.map increment:UPD_POINT_REMOVED];
    }
    
    // Cambia la categoria
    self.category = category;
    
    // añade a la nueva si no estaba marcado como borrado
    if(!self.markedAsDeletedValue) {
        [self.category updateViewCount: UPD_POINT_ADDED];
        [self.category updateViewCountForMap:self.map increment:UPD_POINT_ADDED];
    }
}

//---------------------------------------------------------------------------------------------------------------------
- (BOOL) setLatitude:(double)lat longitude:(double)lng {
    
    // Si hay un cambio de coordenadas las establece y borra la imagen MapThumbnail asociada para que se recalcule
    if(self.latitudeValue!=lat || self.longitudeValue!=lng) {
        self.latitudeValue = lat;
        self.longitudeValue = lng;
        return TRUE;
    } else {
        return FALSE;
    }
}




//=====================================================================================================================
#pragma mark -
#pragma mark Protected methods
//---------------------------------------------------------------------------------------------------------------------
- (void) _resetEntityWithName:(NSString *)name {
    
    [super _resetEntityWithName:name];
        
    self.descr = @"";
    self.latitudeValue = 0.0;
    self.longitudeValue = 0.0;
    
    self.thumbnail.latitudeValue = 0.0;
    self.thumbnail.longitudeValue = 0.0;
    self.thumbnail.imageData = nil;
}


//=====================================================================================================================
#pragma mark -
#pragma mark Private methods
//---------------------------------------------------------------------------------------------------------------------



@end
