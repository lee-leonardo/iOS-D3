//
//  ViewController.m
//  D3iOS
//
//  Created by Leonardo Lee on 12/18/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "ViewController.h"
#import "WebKitController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
#else
#endif

    
}

-(void)viewWillAppear:(BOOL)animated
{
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    WebKitController *wkController = [WebKitController sharedInstance];
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:wkController.config];

    wkWebView.UIDelegate = self;
    wkWebView.navigationDelegate = self;
    
//    wkWebView.title
//    wkWebView.URL
//    wkWebView.loading
//    wkWebView.estimatedProgress
    
    
    [self.view addSubview:wkWebView];
    
    
#else
    
    UIWebView *uiWebView = [[UIWebView alloc] init];
    uiWebView.delegate = _wkController;
    
    NSURLRequest *request = [[NSURLRequest alloc] init];
    [uiWeView loadRequest: request];
    
    
#endif
    
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
//Where the App 'injects' itself.
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    //Handle navigation actions...
    switch (navigationAction.navigationType) {
        case WKNavigationTypeReload:
            //
            break;
            
        case WKNavigationTypeFormResubmitted:
        case WKNavigationTypeFormSubmitted:
            //
            break;
            
        default:
            break;
    }
    
    
    
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    //Handle Reponse
}

#else

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    
}

#endif






@end
