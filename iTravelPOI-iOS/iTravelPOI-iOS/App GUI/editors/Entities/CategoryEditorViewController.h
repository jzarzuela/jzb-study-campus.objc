//
//  CategoryEditorViewController.h
//  iTravelPOI-iOS
//
//  Created by Jose Zarzuela on 31/03/13.
//  Copyright (c) 2013 Jose Zarzuela. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EntityEditorViewController.h"
#import "MCategory.h"
#import "MMap.h"




//*********************************************************************************************************************
#pragma mark -
#pragma mark Public Enumerations & definitions
//*********************************************************************************************************************




//*********************************************************************************************************************
#pragma mark -
#pragma mark Public Interface definition
//*********************************************************************************************************************
@interface CategoryEditorViewController: EntityEditorViewController



//=====================================================================================================================
#pragma mark -
#pragma mark CLASS public methods
//---------------------------------------------------------------------------------------------------------------------
+ (CategoryEditorViewController *) editorWithNewCategoryInContext:(NSManagedObjectContext *)moContext
                                                   parentCategory:(MCategory *)parentCategory
                                                    associatedMap:(MMap *)map;

+ (CategoryEditorViewController *) editorWithCategory:(MCategory *)category
                                        associatedMap:(MMap *)map
                                            moContext:(NSManagedObjectContext *)moContext;


@end
