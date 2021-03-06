//
//  ModelService.h
//  CDTest
//
//  Created by Snow Leopard User on 03/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService-Protected.h"
#import "MEMap.h"



//*********************************************************************************************************************
#pragma mark -
#pragma mark Enumeration & definitions
//---------------------------------------------------------------------------------------------------------------------
typedef void (^TBlock_SyncMapsFinished)(NSError *error);
typedef void (^TBlock_compareMapsFinished)(NSMutableArray *compItems, NSError *error);



//*********************************************************************************************************************
#pragma mark -
#pragma mark SyncService interface definition
//---------------------------------------------------------------------------------------------------------------------
@interface SyncService : BaseService 



//---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark ModelService CLASS public methods
//---------------------------------------------------------------------------------------------------------------------
+ (SyncService *)sharedInstance;



//---------------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark ModelService INSTANCE public methods
//---------------------------------------------------------------------------------------------------------------------
- (SRVC_ASYNCHRONOUS) compareMaps:(TBlock_compareMapsFinished)callbackBlock;
- (SRVC_ASYNCHRONOUS) syncMaps:(NSArray *)compItems callback:(TBlock_SyncMapsFinished)callbackBlock;


@end
