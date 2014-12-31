//
//  WKViewController.m
//  D3iOS
//
//  Created by Leonardo Lee on 12/20/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "D3WKViewController.h"
#import "WebKitController.h"

@interface D3WKViewController ()

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSOperationQueue *scriptQueue;

@end

@implementation D3WKViewController

#pragma mark - UIView
-(void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupWebView];
    [self.view addSubview:_webView];
    
    _scriptQueue = [[NSOperationQueue alloc] init];
    _scriptQueue.qualityOfService = NSOperationQueuePriorityVeryHigh;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:D3_NOTE_JS_MESSAGE_SAMPLE
                                                      object:self
                                                       queue:_scriptQueue
                                                  usingBlock:^(NSNotification *note) {
                                                      
                                                      //From here add these as part of the arguments for the script we are sending this to.
                                                      NSString *name = note.name;
                                                      NSDictionary *jsObject = note.userInfo;
                                                      
                                                      [_webView evaluateJavaScript:@"NEED SOMETHING HERE"
                                                                 completionHandler:^(id object, NSError *error) {
                                                          
                                                      }];
                                                  }];
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:D3_NOTE_UPDATE_DATA
                                                      object:self
                                                       queue:_scriptQueue
                                                  usingBlock:^(NSNotification *note) {
                                                      
                                                      NSString *js = [NSString stringWithFormat:@""];
                                                      
                                                      [_webView evaluateJavaScript:js
                                                                 completionHandler:^(id object, NSError * error) {
                                                                     if (error) {
                                                                         NSLog(@"Error: %@", error.localizedDescription);
                                                                     }
                                                                 }];
                                                  }];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //Remove Observers added!
//    [[NSNotificationCenter defaultCenter] removeObserver:<#(id)#> name:<#(NSString *)#> object:<#(id)#>];
}

#pragma mark - Setup
-(void)setupWebView
{
    WebKitController *wkController = [WebKitController sharedInstance];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 24, self.view.center.y / 3, self.view.frame.size.width - (self.view.frame.size.width / 12), self.view.frame.size.height / 2)
                                  configuration:wkController.config];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.allowsBackForwardNavigationGestures = NO; //This disables the ability to go back and go forward (we will be updating manually).
    
/*//External Example.
    NSURL *url = [NSURL URLWithString:@"https://www.google.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    request = nil; 
 */
   
    //This is found in the D3Samples folder in the Supporting files.
    NSString *indexPath = [[NSBundle mainBundle] pathForResource:EXP_D3_PIE_ROLL ofType:@"html"];
    NSURL *indexURL = [NSURL fileURLWithPath:indexPath];
    NSString *indexFile = [NSString stringWithContentsOfURL:indexURL encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"indexURL: %@", indexURL);
//    NSLog(@"indexfile: %@", indexFile);
    
    [_webView loadHTMLString:indexFile baseURL:indexURL];
    
}

#pragma mark - WKWebView
//Where the App 'injects' itself.

#pragma mark WKNavigationDelegate
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    switch (navigationAction.navigationType) {
        case WKNavigationTypeOther:
        case WKNavigationTypeReload:
            //This is the action for loading from a local HTML document.
            NSLog(@"Navigation Allowed.");
            decisionHandler(WKNavigationActionPolicyAllow);
            break;
            
        case WKNavigationTypeBackForward:
        case WKNavigationTypeFormSubmitted:
        case WKNavigationTypeFormResubmitted:
        case WKNavigationTypeLinkActivated:
            NSLog(@"Navigation Denied.");
            decisionHandler(WKNavigationActionPolicyCancel);
            break;
            
        default:
            break;
    }
    
/*//Sample implementation for future...
     NSURL *url = navigationAction.request.URL;
     if (![url.host.lowercaseString hasPrefix:@"https://"]) {
     decisionHandler(WKNavigationActionPolicyCancel);
     return;
     }
 */
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    //This is not being used at the moment, this would be what would be called right after the decidePolicy, this will return true as long as the type of file is visible at the moment.
    //Handle Reponse
    if (navigationResponse.canShowMIMEType) {
        decisionHandler(WKNavigationResponsePolicyAllow);
    } else {
        decisionHandler(WKNavigationResponsePolicyCancel);
    }
    
}

#pragma mark - IBAction
- (IBAction)refreshWebView:(id)sender {
//    NSLog(@"Reloaded");
    [_webView evaluateJavaScript:@"window.webkit.messageHandlers.{NAME}.postMessage({body: "" })"
               completionHandler:^(id object, NSError * error) {
//        [_webView reload];
    }];
}

@end
