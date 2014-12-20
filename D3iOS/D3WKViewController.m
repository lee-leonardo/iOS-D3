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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear
{
    WebKitController *wkController = [WebKitController sharedInstance];
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:wkController.config];
    
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    
    //    wkWebView.title
    //    wkWebView.URL
    //    wkWebView.loading
    //    wkWebView.estimatedProgress
    
    
    [self.view addSubview:_webView];
}

#pragma mark - WKWebView
//Where the App 'injects' itself.

#pragma mark Navigation Actions
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

#pragma mark Navigation Responses
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    //Handle Reponse
}

@end
