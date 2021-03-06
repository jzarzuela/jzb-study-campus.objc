//
//  UIView+FirstResponder.m
//  iTravelPOI-iOS
//
//  Created by Jose Zarzuela on 31/03/13.
//  Copyright (c) 2013 Jose Zarzuela. All rights reserved.
//

#import "UIView+FirstResponder.h"




//*********************************************************************************************************************
#pragma mark -
#pragma mark UIView_FirstResponder Category implementation
//---------------------------------------------------------------------------------------------------------------------
@implementation UIView (FirstResponder)


//---------------------------------------------------------------------------------------------------------------------
- (UIView *)findFirstResponder {
    
    if ([self isFirstResponder])
        return self;
    
    for (UIView * subView in self.subviews) {
        UIView * fr = [subView findFirstResponder];
        if (fr != nil)
            return fr;
    }
    
    return nil;
}

//---------------------------------------------------------------------------------------------------------------------
- (BOOL) findFirstResponderAndResign {
    return [[self findFirstResponder] resignFirstResponder];
}

//---------------------------------------------------------------------------------------------------------------------
- (BOOL) resignAnyResponder {
    
    BOOL overallResult = FALSE;
    
    if([self respondsToSelector:@selector(resignFirstResponder)]) {
        overallResult |= [self resignFirstResponder];
    }
    
    for(UIView *subview in self.subviews) {
        if([subview respondsToSelector:@selector(resignFirstResponder)]) {
            overallResult |= [subview resignFirstResponder];
            overallResult |= [subview resignAnyResponder];
        }
    }
    return overallResult;
}

@end
