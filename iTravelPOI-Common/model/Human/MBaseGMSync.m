//
//  MBaseGMSync.m
//

#define __MBaseGMSync__IMPL__
#define __MBaseGMSync__PROTECTED__
#define __MBaseEntity__SUBCLASSES__PROTECTED__
#define __MBaseGMSync__SUBCLASSES__PROTECTED__

#import "MBaseGMSync.h"
#import "GMTItem.h"


//*********************************************************************************************************************
#pragma mark -
#pragma mark Private Enumerations & definitions
//*********************************************************************************************************************




//*********************************************************************************************************************
#pragma mark -
#pragma mark PRIVATE interface definition
//*********************************************************************************************************************
@interface MBaseGMSync ()

@end



//*********************************************************************************************************************
#pragma mark -
#pragma mark Implementation
//*********************************************************************************************************************
@implementation MBaseGMSync



//=====================================================================================================================
#pragma mark -
#pragma mark CLASS methods
//---------------------------------------------------------------------------------------------------------------------




//=====================================================================================================================
#pragma mark -
#pragma mark Getter & Setter methods
//---------------------------------------------------------------------------------------------------------------------
- (BOOL) wasSynchronizedValue {
    return ![self.gmID isEqualToString:GM_LOCAL_ID] && ![self.etag isEqualToString:GM_NO_SYNC_ETAG];
}



//=====================================================================================================================
#pragma mark -
#pragma mark Public methods
//---------------------------------------------------------------------------------------------------------------------




//=====================================================================================================================
#pragma mark -
#pragma mark Protected methods
//---------------------------------------------------------------------------------------------------------------------
- (void) _baseUpdateDeleteMark:(BOOL) value {
    self.markedAsDeletedValue = value;
}

//---------------------------------------------------------------------------------------------------------------------
- (void) _resetEntityWithName:(NSString *)name {
    
    [super _resetEntityWithName:name];
    
    self.name = name;
    self.gmID = GM_LOCAL_ID;
    self.etag = GM_NO_SYNC_ETAG;
    self.markedAsDeletedValue = false;
    self.modifiedSinceLastSyncValue = true;
    self.published_date = [NSDate date];
    self.updated_date = self.published_date;
}


//=====================================================================================================================
#pragma mark -
#pragma mark Private methods
//---------------------------------------------------------------------------------------------------------------------



@end
