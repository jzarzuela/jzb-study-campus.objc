//
//  MMap.m
//

#define __MMap__IMPL__
#define __MMap__PROTECTED__
#define __MBaseEntity__SUBCLASSES__PROTECTED__

#import "MMap.h"
#import "MPoint.h"
#import "ErrorManagerService.h"



//*********************************************************************************************************************
#pragma mark -
#pragma mark Private Enumerations & definitions
//*********************************************************************************************************************
#define DEFAULT_MAP_ICON_HREF @"http://maps.gstatic.com/mapfiles/ms2/micons/flag.png"




//*********************************************************************************************************************
#pragma mark -
#pragma mark PRIVATE interface definition
//*********************************************************************************************************************
@interface MMap ()

@end



//*********************************************************************************************************************
#pragma mark -
#pragma mark Implementation
//*********************************************************************************************************************
@implementation MMap



//=====================================================================================================================
#pragma mark -
#pragma mark CLASS methods
//---------------------------------------------------------------------------------------------------------------------
+ (MMap *) emptyMapWithName:(NSString *)name inContext:(NSManagedObjectContext *)moContext {
    
    MMap *map = [MMap insertInManagedObjectContext:moContext];
    [map _resetEntityWithName:name];
    return map;
}

//---------------------------------------------------------------------------------------------------------------------
+ (NSArray *) allMapsInContext:(NSManagedObjectContext *)moContext includeMarkedAsDeleted:(BOOL)withDeleted {
    
    // Crea la peticion de busqueda
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MMap"];
    
    // Se asigna una condicion de filtro
    if(withDeleted == NO) {
        NSPredicate *query = [NSPredicate predicateWithFormat:@"markedAsDeleted=NO"];
        [request setPredicate:query];
    }
    
    // Se asigna el criterio de ordenacion
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:TRUE];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:sortDescriptors];
    
    // Se ejecuta y retorna el resultado
    NSError *localError = nil;
    NSArray *array = [moContext executeFetchRequest:request error:&localError];
    if(array==nil) {
        [ErrorManagerService manageError:localError compID:@"MMap:allMapsInContext" messageWithFormat:@"Error fetching all maps in context [deleted=%d]",withDeleted];
    }
    return array;
}





//=====================================================================================================================
#pragma mark -
#pragma mark Public methods
//---------------------------------------------------------------------------------------------------------------------
- (MODEL_ENTITY_TYPE) entityType {
    return MET_MAP;
}

//---------------------------------------------------------------------------------------------------------------------
- (void) markAsDeleted:(BOOL) value {
    
    // Si ya es igual no hace nada
    if(self.markedAsDeletedValue==value) return;
    
    // Si se esta borrando, eso implica borrar todos los puntos asociados
    if(value==true) {
        for(MPoint *point in self.points) {
            [point markAsDeleted:true];
        }
    }
    
    // Establece el nuevo valor llamando a su clase base
    [super _baseMarkAsDeleted:value];
}

//---------------------------------------------------------------------------------------------------------------------
- (void) markAsModified {

    // Establece el nuevo valor llamando a su clase base
    [super _baseMarkAsModified];
}

//---------------------------------------------------------------------------------------------------------------------
- (NSString *) strViewCount {
    return [NSString stringWithFormat:@"%03d", self.viewCountValue];
}





//=====================================================================================================================
#pragma mark -
#pragma mark Protected methods
//---------------------------------------------------------------------------------------------------------------------
- (void) _resetEntityWithName:(NSString *)name {
    
    [super _resetEntityWithName:name iconHref:DEFAULT_MAP_ICON_HREF];
    self.viewCountValue = 0;
    self.summary = @"";
}

//---------------------------------------------------------------------------------------------------------------------
- (void) updateViewCount:(int) increment {
    self.viewCountValue += increment;
    assert(self.viewCountValue>=0);
}



//=====================================================================================================================
#pragma mark -
#pragma mark Private methods
//---------------------------------------------------------------------------------------------------------------------




@end
