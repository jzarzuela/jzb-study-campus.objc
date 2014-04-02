//
//  SyncDataSource.m
//  iTravelPOI-iOS
//
//  Created by Jose Zarzuela on 28/03/14.
//  Copyright (c) 2014 Jose Zarzuela. All rights reserved.
//

#define __SyncDataSource__IMPL__
#import "SyncDataSource.h"




//*********************************************************************************************************************
#pragma mark -
#pragma mark Private Enumerations & definitions
//*********************************************************************************************************************
#define  EXAMPLE_VALUE_PRIV "example value"




//*********************************************************************************************************************
#pragma mark -
#pragma mark PRIVATE interface definition
//*********************************************************************************************************************
@interface SyncDataSource()


@property (nonatomic, strong) NSString *privateProperty;


+ (void) privateClassMethod;
- (void) privateMethod;

@end




//*********************************************************************************************************************
#pragma mark -
#pragma mark Implementation
//*********************************************************************************************************************
@implementation SyncDataSource


@synthesize publicProperty = _publicProperty;
@synthesize privateProperty = _privateProperty;




//=====================================================================================================================
#pragma mark -
#pragma mark CLASS methods
//---------------------------------------------------------------------------------------------------------------------
+ (void) publicClassMethod {

}

//---------------------------------------------------------------------------------------------------------------------
+ (void) privateClassMethod {

}




//=====================================================================================================================
#pragma mark -
#pragma mark Getter & Setter methods
//---------------------------------------------------------------------------------------------------------------------




//=====================================================================================================================
#pragma mark -
#pragma mark Public methods
//---------------------------------------------------------------------------------------------------------------------
- (void) publicMethod {

}




//=====================================================================================================================
#pragma mark -
#pragma mark Private methods
//---------------------------------------------------------------------------------------------------------------------
- (void) privateMethod {

}

@end

