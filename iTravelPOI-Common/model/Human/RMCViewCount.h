//
//  RMCViewCount.h
//


#import "_RMCViewCount.h"



//*********************************************************************************************************************
#pragma mark -
#pragma mark Public Interface definition
//*********************************************************************************************************************
@interface RMCViewCount : _RMCViewCount {}


//=====================================================================================================================
#pragma mark -
#pragma mark CLASS public methods
//---------------------------------------------------------------------------------------------------------------------
+ (RMCViewCount *) rmcViewCountForMap:(MMap *)map category:(MCategory *)category;


//=====================================================================================================================
#pragma mark -
#pragma mark INSTANCE public methods
//---------------------------------------------------------------------------------------------------------------------
- (void) updateViewCount:(int) increment;


@end
