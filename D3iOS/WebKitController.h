//
//  WebKitController.h
//  D3iOS
//
//  Created by Leonardo Lee on 12/18/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "Constants.h"

@interface WebKitController : NSObject <WKScriptMessageHandler>

@property (nonatomic, strong) WKWebViewConfiguration *config;
@property (nonatomic, strong) WKUserContentController *contentController;
@property (nonatomic, strong) WKUserScript *d3script;


+(id)sharedInstance;

@end
