//
//  WebKitController.m
//  D3iOS
//
//  Created by Leonardo Lee on 12/18/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "WebKitController.h"

@interface WebKitController ()

@end

@implementation WebKitController

+(id)sharedInstance
{
    static WebKitController *sharedWebKitController;
    static dispatch_once_t webkitToken;
    
    dispatch_once(&webkitToken, ^{
        sharedWebKitController = [[self alloc] init];
    });
    
    return sharedWebKitController;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
        
        _contentController = [[WKUserContentController alloc] init];
        
        [self setupD3];
        
        
        //        *connected = ;
        
        //        if (connected) {
        //            [NSURL URLWithString:@"http://d3js.org/d3.v3.min.js"];
        //        }
        
        //        _contentController addScriptMessageHandler:<#(id<WKScriptMessageHandler>)#> name:<#(NSString *)#>
        
        
        
        
        
        
#else
#endif
    }
    return self;
}


#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0

#pragma mark - Setup
-(void)setupD3
{
    NSString *source = [[NSString alloc] init];
    
    _d3script = [[WKUserScript alloc] initWithSource:source injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    
    [_contentController addUserScript:_d3script];
}

#pragma mark - WKWebView
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
}
#else


#endif

@end
