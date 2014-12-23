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
/*
    Scripts can be injected in the ViewController, code inject during this step would be code that needs to be in the WebView prior to the loading of the WebView.
 */

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
/*
    Adds D3 to the WKWebView. It first pulls a copy of it from disk, then replaces it with one from the web.
 */

    __block NSString *d3Lib = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"d3.min" withExtension:@".js"] encoding:NSUTF8StringEncoding error:NULL];
    
    _d3script = [[WKUserScript alloc] initWithSource:d3Lib injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
    
    //This code allows one to make a request to the internet and download the latest copy of D3.
    BOOL connected = YES; //I am thinking of changing this so that it will only run when on WiFi.
    if (connected) {
        NSURL *d3url = [[NSURL alloc] initWithString:D3_MIN_URL];
        NSURLRequest *d3request = [NSURLRequest requestWithURL:d3url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];

        /* //This is actually a possible way to grab the d3 Library. However this is unsafe and does not allow us to check if we got a correct response.
        NSString *isItPossible = [NSString stringWithContentsOfURL:d3url encoding:NSStringEncodingConversionExternalRepresentation error:nil];
        NSLog(@"%@", isItPossible);
        */
        
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
                            //Grabs the D3 Javascript library.
                            d3Lib = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                            //NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
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
-(void)addUserScriptToContentController:(WKUserScript *)userScript
{
    [_contentController addUserScript:userScript];
}

-(void)addUserScriptToContentController:(WKUserScript *)userScript withMessageHander:(NSString *)handlerName
{
    [_contentController addUserScript:userScript];
    
    //This is the way to register the types of messages that will be received by the app.
    [_contentController addScriptMessageHandler:self name:handlerName];
    
}

-(void)downloadScriptFromURL:(NSURL *)url
{
    /*
     While using this method, besure to add the message to be required method of the WKScriptMessageHandler protocol.
     */
    
    __block NSString *scriptString;
    __block WKUserScript *userScript;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *d3FetchRequest = [self.wkSession dataTaskWithRequest:request
                                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                 if (error) {
                                                                     NSLog(@"Error %@", error.localizedDescription);
                                                                 } else {
                                                                     if ([response respondsToSelector:@selector(statusCode)]) {
                                                                         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                                         NSInteger responseCode = [httpResponse statusCode];
                                                                         switch (responseCode) {
                                                                             case 200:
                                                                                 scriptString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                                                 userScript = [[WKUserScript alloc] initWithSource:scriptString injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
                                                                                 
                                                                                 [self addUserScriptToContentController:userScript];
                                                                                 break;
                                                                                 
                                                                             default:
                                                                                 break;
                                                                         }
                                                                     }
                                                                 }
                                                                 NSLog(@"Response: %@", response);
                                                             }];
    [d3FetchRequest resume];
}

-(void)downloadScriptFromURL:(NSURL *)url withMessageHandler:(NSString *)messageName
{
    /*
        While using this method, besure to add the message to be required method of the WKScriptMessageHandler protocol.
     */
    
    __block NSString *scriptString;
    __block WKUserScript *userScript;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *d3FetchRequest = [self.wkSession dataTaskWithRequest:request
                                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                 if (error) {
                                                                     NSLog(@"Error %@", error.localizedDescription);
                                                                 } else {
                                                                     if ([response respondsToSelector:@selector(statusCode)]) {
                                                                         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                                         NSInteger responseCode = [httpResponse statusCode];
                                                                         switch (responseCode) {
                                                                             case 200:
                                                                                 scriptString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                                                 userScript = [[WKUserScript alloc] initWithSource:scriptString injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
                                                                                 
                                                                                 [self addUserScriptToContentController:userScript withMessageHander:messageName];
                                                                                 break;
                                                                                 
                                                                             default:
                                                                                 break;
                                                                         }
                                                                     }
                                                                 }
                                                                 NSLog(@"Response: %@", response);
                                                             }];
    [d3FetchRequest resume];
}

#pragma mark - WKScriptMessageHandler
/*
    The WKContentController is what handles the messages to and from a WKWebView.
    This is for code injection and the notification of events + what to do with new events. Received messages are received as JSON and converted to ObjC Types.
 */
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //Use the message.name property to figure out which message has been received.
    //message.webView is the related WebView.
    //message.body is a JSON object.
    
    NSLog(@"Message Received\nName: %@\nBody:%@", message.name, message.body);
    
    //Post a notification here
//    [[NSNotificationCenter defaultCenter] postNotificationName:D3_JS_MESSAGE_SAMPLE object:self userInfo:<#(NSDictionary *)#>]
}

@end
