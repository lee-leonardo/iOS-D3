//
//  WebKitController.m
//  D3iOS
//
//  Created by Leonardo Lee on 12/18/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "WebKitController.h"

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
        
        _config = [[WKWebViewConfiguration alloc] init];
//        _config.preferences
//        _config.processPool
        
        _contentController = [[WKUserContentController alloc] init];
        _config.userContentController = _contentController;
        
        
        _wkQueue = [[NSOperationQueue alloc] init];
        _wkQueue.qualityOfService = NSOperationQualityOfServiceUserInitiated;
        
        _wkSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        //Customize Session
        
        _wkSession = [NSURLSession sessionWithConfiguration:_wkSessionConfig delegate:self delegateQueue:_wkQueue];
        
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
    //Target to get: http://bl.ocks.org/mbostock/4061502
}

-(void)setupD3
{
    //Will replace this with a future. The future will be used to handle the updates from the server as well?
    
    NSString *d3Lib = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"d3.min" withExtension:@".js"] encoding:NSUTF8StringEncoding error:NULL];
    
    _d3script = [[WKUserScript alloc] initWithSource:d3Lib injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
    
    BOOL connected = NO; //Going to make this a request to D3 to pull a newer version of D3.js to replace the overwrite the older one.
    if (connected) {
        NSURL *d3url = [[NSURL alloc] initWithString:D3_MIN_URL];
        NSURLRequest *d3request = [NSURLRequest requestWithURL:d3url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
        
        //GET request, this should pull down a copy of the repo.
        [[self.wkSession dataTaskWithRequest:d3request
                          completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"Error %@", error.localizedDescription);
            } else {
                if ([response respondsToSelector:@selector(statusCode)]) {
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                    NSInteger responseCode = [httpResponse statusCode];
                    switch (responseCode) {
                        case 200:
                            //Handle Script Creation.
                            NSLog(@"Data: %@", data);
                            break;
                            
                        default:
                            break;
                    }
                    
                }
            }
        }] resume];
    }
//    NSLog(@"D3 File: %@", _d3script.source);
    
    [_contentController addUserScript:_d3script];
}

#pragma mark - Adding User Scripts
-(void)addUserScriptsToContentController:(WKUserScript *)userScript
{
    [_contentController addUserScript:userScript];
}

-(void)addUserScriptsToContentController:(WKUserScript *)userScript withMessageHander:(NSString *)handlerName
{
    [_contentController addUserScript:userScript];
    
    //This is the way to register the types of messages that will be received by the app.
    [_contentController addScriptMessageHandler:self name:handlerName];
    
}

//-(WKUserScript *)downloadScriptFromURL:(NSURL *)url
//{
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    NSURLSessionDataTask *d3FetchRequest = [self.wkSession dataTaskWithRequest:request
//                                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                                                                 if (error) {
//                                                                     NSLog(@"Error %@", error.localizedDescription);
//                                                                 } else {
//                                                                     if ([response respondsToSelector:@selector(statusCode)]) {
//                                                                         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//                                                                         NSInteger responseCode = [httpResponse statusCode];
//                                                                         switch (responseCode) {
//                                                                             case 200:
//                                                                                 //
//                                                                                 break;
//                                                                                 
//                                                                             default:
//                                                                                 break;
//                                                                         }
//                                                                         
//                                                                     }
//                                                                 }
//                                                                 
//                                                                 NSLog(@"Response: %@", response);
//                                                             }];
//    [d3FetchRequest resume];
//}

//-(WKUserScript *)createUserScriptWithPath:(NSString *)path andType:(NSString *)type
//{
//    NSString *source = [[NSString alloc] init]; //This is actually where I need to call an initWithURL...
//    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:source injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
//    return userScript;
//}

#pragma mark - WKScriptMessageHandler
//This is for code injection and the notification of events + what to do with new events.
//Received messages are received as JSON and converted to ObjC Types.

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //Use the message.name property to figure out which message has been received.
}

@end
