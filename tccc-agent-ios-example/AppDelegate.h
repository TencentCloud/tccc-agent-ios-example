//
//  AppDelegate.h
//  tccc-agent-ios-example
//
//  Created by gavinwjwang on 2023/12/14.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow * window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;


@end

