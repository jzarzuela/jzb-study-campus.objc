//
//  MBaseSync.h
//


#import "_MBaseSync.h"
#import "GMPComparable.h"



//*********************************************************************************************************************
#pragma mark -
#pragma mark Public Enumerations & definitions
//*********************************************************************************************************************




//*********************************************************************************************************************
#pragma mark -
#pragma mark Public Interface definition
//*********************************************************************************************************************
@interface MBaseSync : _MBaseSync <GMPComparableLocal>


//=====================================================================================================================
#pragma mark -
#pragma mark CLASS public methods
//---------------------------------------------------------------------------------------------------------------------


//=====================================================================================================================
#pragma mark -
#pragma mark INSTANCE public methods
//---------------------------------------------------------------------------------------------------------------------
- (BOOL) updateGID:(NSString *)gID andETag:(NSString *)etag;
- (void) markAsDeleted:(BOOL) value;
- (void) markAsSynchronized;


//=====================================================================================================================
#pragma mark -
#pragma mark SUBCLASSES PROTECTED methods
//---------------------------------------------------------------------------------------------------------------------


@end
