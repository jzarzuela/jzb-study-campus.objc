//
//  AppDelegate.m
//  iTravelPOI-iOS
//
//  Created by Jose Zarzuela on 22/12/13.
//  Copyright (c) 2013 Jose Zarzuela. All rights reserved.
//

#import "AppDelegate.h"

#import "BaseCoreDataService.h"
#import "MockUp.h"
#import "DDTTYLogger.h"

#import "MMap.h"
#import "MPoint.h"

#import <MapKit/MapKit.h>



// *********************************************************************************************************************
#pragma mark -
#pragma mark PRIVATE interface definition
// *********************************************************************************************************************
@interface AppDelegate()

@end



// *********************************************************************************************************************
#pragma mark -
#pragma mark Implementation
// *********************************************************************************************************************
@implementation AppDelegate



// =====================================================================================================================
#pragma mark -
#pragma mark <UIApplicationDelegate> methods
// ---------------------------------------------------------------------------------------------------------------------
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    // Establece un gestor especial de excepciones
    NSSetUncaughtExceptionHandler(&_uncaughtExceptionHandler);
    
    // Inicializa el sistema de logging
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    // Inicializa el modelo de datos
    [self _initDataModel];
    
    // Inicializa la carpeta para los mapas offline y los backups
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *offlineMapPath = [documentsDirectory stringByAppendingPathComponent:@"offlineMaps"];
    [[NSFileManager defaultManager] createDirectoryAtPath:offlineMapPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *backupMapPath = [documentsDirectory stringByAppendingPathComponent:@"backup"];
    [[NSFileManager defaultManager] createDirectoryAtPath:backupMapPath withIntermediateDirectories:YES attributes:nil error:nil];

    
    // Se crea la ventana y controller inicial de la aplicación
    UIViewController *viewController = self.window.rootViewController;
    viewController.view.tintColor = [UIColor orangeColor];

    return YES;
}
							
// ---------------------------------------------------------------------------------------------------------------------
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

// ---------------------------------------------------------------------------------------------------------------------
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

// ---------------------------------------------------------------------------------------------------------------------
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

// ---------------------------------------------------------------------------------------------------------------------
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

// ---------------------------------------------------------------------------------------------------------------------
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


// =====================================================================================================================
#pragma mark -
#pragma mark Private methods
// ---------------------------------------------------------------------------------------------------------------------
void _uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    // Internal error reporting
}


// ---------------------------------------------------------------------------------------------------------------------
- (void) _initDataModel {
    
    // ---------------------------------------
    // ---------------------------------------
////////    [MockUp resetModel:@"iTravelPOI-Model"];
    // ---------------------------------------
    // ---------------------------------------
    
    
    if(![BaseCoreDataService initCDStack:@"iTravelPOI-Model"]) {
        abort();
    }
    
    
    // ---------------------------------------
    // ---------------------------------------
//////// [MockUp populateModelFromPListFiles];
    // ---------------------------------------
    // ---------------------------------------

    // ---------------------------------------
    // ---------------------------------------
//////// [MockUp listModel];
    // ---------------------------------------
    // ---------------------------------------

}

@end
