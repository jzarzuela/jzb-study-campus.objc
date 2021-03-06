//
//  MPoint.h
//


#import "_MPoint.h"



//*********************************************************************************************************************
#pragma mark -
#pragma mark Public Interface definition
//*********************************************************************************************************************
@interface MPoint : _MPoint


//=====================================================================================================================
#pragma mark -
#pragma mark CLASS public methods
//---------------------------------------------------------------------------------------------------------------------
+ (MPoint *) emptyPointWithName:(NSString *)name inMap:(MMap *)map withCategory:(MCategory *)category;

+ (NSArray *) pointsInMap:(MMap *)map category:(MCategory *)cat;



// =====================================================================================================================
#pragma mark -
#pragma mark INSTANCE public methods
// ---------------------------------------------------------------------------------------------------------------------
- (void) moveToCategory:(MCategory *)category;
- (BOOL) setLatitude:(double)lat longitude:(double)lng;


@end
