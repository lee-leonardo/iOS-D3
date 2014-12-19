//
//  WebKitController.h
//  D3iOS
//
//  Created by Leonardo Lee on 12/18/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
#import <WebKit/WebKit.h>
@interface WebKitController : NSObject <WKScriptMessageHandler>

@property (nonatomic, strong) WKWebViewConfiguration *config;
@property (nonatomic, strong) WKUserContentController *contentController;
@property (nonatomic, strong) WKUserScript *d3script;


+(id)sharedInstance;

@end

#else
@interface WebKitController : NSObject

+(id)sharedInstance;

@end
#endif



