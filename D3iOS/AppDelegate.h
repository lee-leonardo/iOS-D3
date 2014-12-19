//
//  AppDelegate.h
//  D3iOS
//
//  Created by Leonardo Lee on 12/18/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebKitController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) WebKitController *wkController;

@end

