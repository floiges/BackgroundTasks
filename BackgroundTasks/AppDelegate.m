//
//  AppDelegate.m
//  BackgroundTasks
//
//  Created by 224 on 15/3/20.
//  Copyright (c) 2015年 zoomlgd. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //设定获取间隔
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    return YES;
}

//实现后台获取代码并通知系统
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    //完成获取工作，刷新UI，并通知系统获取结束，以便系统尽快回到休眠状态
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *viewController = [storyBoard instantiateInitialViewController];
    
    id fetchViewController = viewController;
    if ([fetchViewController respondsToSelector:@selector(fetchDataResult:)]) {
        [fetchViewController fetchDataResult:^(NSError *error,NSArray *result){
            if (!error) {
                if (result.count != 0) {
                    //Update UI with result
                    //Tell system all done.
                    
                    //获取了新数据，此时系统将对现在的UI状态截图并更新App Switcher中你的应用的截屏
                    completionHandler(UIBackgroundFetchResultNewData);
                }else {
                    completionHandler(UIBackgroundFetchResultNoData);
                }
            }else {
                completionHandler(UIBackgroundFetchResultFailed);
            }
        }];
    }else {
        completionHandler(UIBackgroundFetchResultFailed);
    }
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler
{
    //Check if all transfers are done ,and update UI
    //Then tell system background transfer over, so it can take new snapshot to show in App Switcher
    completionHandler();
    
    //You can also pop up a local notification to remind the user
    //...
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
