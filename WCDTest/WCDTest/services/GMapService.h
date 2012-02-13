//
//  GMapService.h
//  WCDTest
//
//  Created by jzarzuela on 11/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMap.h"
#import "TCategory.h"
#import "TPoint.h"

#define ASYNCHRONOUS void
typedef void (^TBlock_FetchUserMapListFinished)(NSArray *maps, NSError *error);
typedef void (^TBlock_FetchMapDataFinished)(TMap *map, NSError *error);
typedef void (^TBlock_CreateMapDataFinished)(TMap *map, NSError *error);
typedef void (^TBlock_DeleteMapDataFinished)(TMap *map, NSError *error);



//*********************************************************************************************************************
//---------------------------------------------------------------------------------------------------------------------
@protocol GMapServiceCallback <NSObject>

@optional
- (NSArray *) fetchUserMapListDidFinished;

@end

//*********************************************************************************************************************
//---------------------------------------------------------------------------------------------------------------------
@interface GMapService : NSObject {
}


//---------------------------------------------------------------------------------------------------------------------
+ (GMapService *)sharedInstance;


//---------------------------------------------------------------------------------------------------------------------
- (void) loginWithUser:(NSString *)email password:(NSString *)password;
- (void) logout;
- (BOOL) isLoggedIn;

- (ASYNCHRONOUS) fetchUserMapList:(TBlock_FetchUserMapListFinished)callbackBlock;
- (ASYNCHRONOUS) fetchMapData:(TMap *)map callback:(TBlock_FetchMapDataFinished)callbackBlock;

@end
