//
//  MyImageView.m
//  iTravelPOI-Mac
//
//  Created by Jose Zarzuela on 26/01/13.
//  Copyright (c) 2013 Jose Zarzuela. All rights reserved.
//

#define __MyImageView__IMPL__
#import "MyImageView.h"




//*********************************************************************************************************************
#pragma mark -
#pragma mark Private Service Enumerations & definitions
//*********************************************************************************************************************




//*********************************************************************************************************************
#pragma mark -
#pragma mark PRIVATE interface definition
//*********************************************************************************************************************
@interface MyImageView()


@end




//*********************************************************************************************************************
#pragma mark -
#pragma mark Implementation
//*********************************************************************************************************************
@implementation MyImageView


//=====================================================================================================================
#pragma mark -
#pragma mark CLASS methods
//---------------------------------------------------------------------------------------------------------------------




//=====================================================================================================================
#pragma mark -
#pragma mark Getter & Setter methods
//---------------------------------------------------------------------------------------------------------------------




//=====================================================================================================================
#pragma mark -
#pragma mark Public methods
//---------------------------------------------------------------------------------------------------------------------
- (void)mouseDown:(NSEvent *)theEvent {
    
    [super mouseDown:theEvent];

    if([self.target conformsToProtocol:@protocol(MyImageViewDelegate)]) {
        id<MyImageViewDelegate> myDelegate = self.target;
        NSPoint local_point = [self convertPoint:theEvent.locationInWindow fromView:nil];
        [myDelegate myImageViewClicked:self inPoint:local_point];
    }
}




//=====================================================================================================================
#pragma mark -
#pragma mark Private methods
//---------------------------------------------------------------------------------------------------------------------


@end
