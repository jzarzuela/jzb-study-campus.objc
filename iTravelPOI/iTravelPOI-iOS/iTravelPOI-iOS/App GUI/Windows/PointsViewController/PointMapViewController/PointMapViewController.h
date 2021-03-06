//
//  PointMapViewController.h
//  iTravelPOI-iOS
//
//  Created by Jose Zarzuela on 22/12/13.
//  Copyright (c) 2013 Jose Zarzuela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointsControllerDelegate.h"


@class MMap;



//*********************************************************************************************************************
#pragma mark -
#pragma mark Public Enumerations & definitions
//*********************************************************************************************************************




//*********************************************************************************************************************
#pragma mark -
#pragma mark Public Interface definition
//*********************************************************************************************************************
@interface PointMapViewController : UIViewController <PointsViewerProtocol>



//=====================================================================================================================
#pragma mark -
#pragma mark CLASS public methods
//---------------------------------------------------------------------------------------------------------------------



//=====================================================================================================================
#pragma mark -
#pragma mark INSTANCE public methods
//---------------------------------------------------------------------------------------------------------------------
- (CLLocationCoordinate2D) mapCenter;
- (void) zoomOnMyLocation;
- (void) switchCompassMode;
- (void) zoomAndShowAll;
- (void) zoomOnSelected;
- (void) toggleOfflineMap:(MMap *)map;


@end
