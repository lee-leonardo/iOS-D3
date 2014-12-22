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
}

#pragma mark - Setup
-(void)setupWebView
{
    WebKitController *wkController = [WebKitController sharedInstance];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(16, 44, self.view.frame.size.width, self.view.frame.size.height)
                                  configuration:wkController.config];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    
    //External.
//    NSURL *url = [NSURL URLWithString:@"https://www.google.com"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [_webView loadRequest:request];
//    request = nil;
    
    NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"simpleExample" ofType:@"html"];
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
            //This is the action for loading from a local HTML document.
            decisionHandler(WKNavigationActionPolicyAllow);
            break;
            
        case WKNavigationTypeBackForward:
        case WKNavigationTypeFormResubmitted:
        case WKNavigationTypeFormSubmitted:
        case WKNavigationTypeLinkActivated:
        case WKNavigationTypeReload:
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

@end
