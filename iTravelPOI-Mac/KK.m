//
//  KK.m
//  iTravelPOI-Mac
//
//  Created by Jose Zarzuela on 31/08/12.
//  Copyright (c) 2012 Jose Zarzuela. All rights reserved.
//

#import "KK.h"




//*********************************************************************************************************************
#pragma mark -
#pragma mark Private enumerations & definitions
//---------------------------------------------------------------------------------------------------------------------
#define  EXAMPLE_VALUE_PRIV "example value"




//*********************************************************************************************************************
#pragma mark -
#pragma mark KK Private interface definition
//---------------------------------------------------------------------------------------------------------------------
@interface KK()


@property (nonatomic, strong) NSString * privPropExample;



+ (void) privExampleClass;
- (void) privExample;


@end




//*********************************************************************************************************************
#pragma mark -
#pragma mark KK implementation
//---------------------------------------------------------------------------------------------------------------------
@implementation KK


@synthesize propExample = _propExample;
@synthesize privPropExample = _privPropExample;




//---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark CLASS public methods
//---------------------------------------------------------------------------------------------------------------------
+ (void) exampleClass {

}



//---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Getter & Setter methods
//---------------------------------------------------------------------------------------------------------------------
- (NSString *) propExample {
	return _propExample;
}



//---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Public methods
//---------------------------------------------------------------------------------------------------------------------
- (void) example {

}



//---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark CLASS private methods
//---------------------------------------------------------------------------------------------------------------------
+ (void) privExampleClass {

}



//---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Private methods
//---------------------------------------------------------------------------------------------------------------------
- (void) privExample {

}

@end

