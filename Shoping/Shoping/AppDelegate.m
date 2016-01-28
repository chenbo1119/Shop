//
//  AppDelegate.m
//  Shoping
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 boge. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = [self createRootViewController];
    
    [_window makeKeyAndVisible];
    return YES;
}

- (MainTabBarViewController *)createRootViewController
{
    NSArray *names = @[@"SPViewController", @"FLViewController", @"HHViewController", @"ZTViewController", @"WDViewController"];
    NSArray *titles = @[@"商品", @"分类", @"好货", @"专题", @"我的"];
    NSArray *images = @[@"商品-A.png", @"分类-A.png", @"好货-A.png", @"专题-A.png", @"我的-A.png"];
    NSArray *seletedImages = @[@"商品-B.png", @"分类-B.png", @"好货-B.png", @"专题-B.png", @"我的-B.png"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < names.count; i ++) {
        Class class = NSClassFromString(names[i]);
        UIViewController *vc = [[class alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:titles[i] image:[UIImage imageNamed:images[i]] selectedImage:[UIImage imageNamed:seletedImages[i]]];
        nav.tabBarItem = item;
        [array addObject:nav];
    }
    MainTabBarViewController *main = [[MainTabBarViewController alloc]init];
    main.viewControllers = array;

    return main;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
