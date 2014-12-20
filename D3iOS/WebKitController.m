//
//  WebKitController.m
//  D3iOS
//
//  Created by Leonardo Lee on 12/18/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "WebKitController.h"


NSString * const D3IOS_APPURL = @"d3ios";


@interface WebKitController ()

@end

@implementation WebKitController

+(id)sharedInstance
{
    static WebKitController *sharedWebKitController; //= nil;
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
    
    //Check if on wifi, if on wifi download the latest version of D3
    //If I have time save to disk (overwrite)?
    //        if (connected) {
    //            [NSURL URLWithString:@"http://d3js.org/d3.v3.min.js"];
    //        }
    
    _d3script = [[WKUserScript alloc] initWithSource:source injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    
    [_contentController addUserScript:_d3script];
}

#pragma mark - Adding User Scripts
-(void)addUserScriptsToContentController:(WKUserScript *)userScript
{
    [_contentController addUserScript:userScript];
}

-(WKUserScript *)createUserScriptWithPath:(NSString *)path andType:(NSString *)type
{
    
    NSString *source = [[NSString alloc] init]; //This is actually where I need to call an initWithURL...
    
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:source injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    
//    NSString *contents = [NSString
    
    
    return userScript;
}

#pragma mark - WKScriptMessageHandler
//This is for code injection and the notification of events + what to do with new events.
//Received messages are received as JSON and converted to ObjC Types.

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
}
//#else
#endif

@end
