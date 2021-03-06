//
//  MMap.h
//


#import "_MMap.h"


//*********************************************************************************************************************
#pragma mark -
#pragma mark Public Enumerations & definitions
//*********************************************************************************************************************




//*********************************************************************************************************************
#pragma mark -
#pragma mark Public Interface definition
//*********************************************************************************************************************
@interface MMap : _MMap {}


//=====================================================================================================================
#pragma mark -
#pragma mark CLASS public methods
//---------------------------------------------------------------------------------------------------------------------
+ (MMap *)     emptyMapWithName:(NSString *)name inContext:(NSManagedObjectContext *)moContext;
+ (NSArray *)  allMapsinContext:(NSManagedObjectContext *)moContext includeMarkedAsDeleted:(BOOL)withDeleted;
+ (NSArray *)  mapsWithName:(NSString *)name inContext:(NSManagedObjectContext *)moContext;


//=====================================================================================================================
#pragma mark -
#pragma mark INSTANCE public methods
//---------------------------------------------------------------------------------------------------------------------
- (BOOL)      updateSummary:(NSString *)value;
- (NSInteger) pointsCount;

@end
