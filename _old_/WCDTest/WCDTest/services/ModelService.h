//
//  ModelService.h
//  CDTest
//
//  Created by Snow Leopard User on 03/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMap.h"
#import "TCategory.h"
#import "TPoint.h"

//*********************************************************************************************************************
//---------------------------------------------------------------------------------------------------------------------
@interface ModelService : NSObject {
}

@property (readonly, nonatomic, retain) NSManagedObjectContext * moContext;


//---------------------------------------------------------------------------------------------------------------------
+ (ModelService *)sharedInstance;


//---------------------------------------------------------------------------------------------------------------------
- (void) initCDStack;
- (void) doneCDStack;
- (void) saveContext;


- (NSArray *)getUserMapList:(NSError * __autoreleasing *)error;

@end
