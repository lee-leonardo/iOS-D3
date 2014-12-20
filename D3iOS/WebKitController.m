//
//  WebKitController.m
//  D3iOS
//
//  Created by Leonardo Lee on 12/18/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "WebKitController.h"

//NSString * const D3IOS_APPURL = @"d3ios";

@interface WebKitController () <NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSessionConfiguration *wkSessionConfig;
@property (nonatomic, weak) NSURLSession *wkSession;
@property (nonatomic, strong) NSOperationQueue *wkQueue;

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
        
        _wkQueue = [[NSOperationQueue alloc] init];
        _wkQueue.qualityOfService = NSOperationQualityOfServiceUserInitiated;
        
        _wkSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        //Customize Session
        
        _wkSession = [NSURLSession sessionWithConfiguration:_wkSessionConfig delegate:self delegateQueue:_wkQueue];
        _contentController = [[WKUserContentController alloc] init];
        
        [self setupWebView];
    }
    return self;
}

#pragma mark - Setup
-(void)setupWebView
{
    [self setupD3];
    
//    WKUserScript *sampleScript = [WKUserScript alloc] initWithSource:<#(NSString *)#> injectionTime:<#(WKUserScriptInjectionTime)#> forMainFrameOnly:<#(BOOL)#>
//    [self addUserScriptsToContentController:<#(WKUserScript *)#>];
    
    //You may add other Scripts Here.
}

-(void)setupD3
{
    //Will replace this with a future. The future will be used to handle the updates from the server as well?
    
    NSString *d3Lib = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"d3.min" withExtension:@".js"] encoding:NSUTF8StringEncoding error:NULL];
    
    _d3script = [[WKUserScript alloc] initWithSource:d3Lib injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
    
    BOOL connected = NO; //Going to make this a request to D3 to pull a newer version of D3.js to replace the overwrite the older one.
    if (connected) {
        NSURL *d3url = [[NSURL alloc] initWithString:@"http://d3js.org/d3.v3.min.js"];
        NSURLRequest *d3request = [NSURLRequest requestWithURL:d3url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
        
        [_wkSession downloadTaskWithRequest:d3request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            //This is where D3 from the Web will be loaded into the future.
        }];
    }
    NSLog(@"D3 File: %@", _d3script.source);
    
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
    
    return userScript;
}

#pragma mark - WKScriptMessageHandler
//This is for code injection and the notification of events + what to do with new events.
//Received messages are received as JSON and converted to ObjC Types.

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
}

@end
