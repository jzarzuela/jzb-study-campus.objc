//
//  TagFilterViewController.h
//  iTravelPOI-iOS
//
//  Created by Jose Zarzuela on 22/12/13.
//  Copyright (c) 2013 Jose Zarzuela. All rights reserved.
//

#import <UIKit/UIKit.h>




//*********************************************************************************************************************
#pragma mark -
#pragma mark Public Enumerations & definitions
//*********************************************************************************************************************




//*********************************************************************************************************************
#pragma mark -
#pragma mark Public Interface definition
//*********************************************************************************************************************
@interface TagFilterViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *moContext;
@property (nonatomic, strong) NSMutableArray *filter;




//=====================================================================================================================
#pragma mark -
#pragma mark CLASS public methods
//---------------------------------------------------------------------------------------------------------------------



//=====================================================================================================================
#pragma mark -
#pragma mark INSTANCE public methods
//---------------------------------------------------------------------------------------------------------------------



@end
