//
//  WebKitController.h
//  D3iOS
//
//  Created by Leonardo Lee on 12/18/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface WebKitController : NSObject

@property (nonatomic, strong) WKWebViewConfiguration *config;


+(id)sharedInstance;

@end
