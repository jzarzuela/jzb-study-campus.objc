//
//  ModelService.h
//  CDTest
//
//  Created by Snow Leopard User on 03/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


//*********************************************************************************************************************
//---------------------------------------------------------------------------------------------------------------------
@interface ModelService : NSObject {
}

@property (readonly, nonatomic, retain) NSManagedObjectContext * moContext;
@property (readonly, nonatomic, retain) NSManagedObjectContext * moTmpContext;


//---------------------------------------------------------------------------------------------------------------------
+ (ModelService *)sharedInstance;


//---------------------------------------------------------------------------------------------------------------------
- (void) initCDStack;
- (void) doneCDStack;
- (void) saveContext;


@end
