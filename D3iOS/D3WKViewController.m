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
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:wkController.config];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    
    NSURL *url = [NSURL URLWithString:@"https://www.google.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
//    NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    NSURL *indexURL = [NSURL fileURLWithPath:indexPath];
//    NSString *indexFile = [NSString stringWithContentsOfURL:indexURL encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"indexURL: %@", indexURL);
//    NSLog(@"indexfile: %@", indexFile);
    
//    [_webView loadHTMLString:indexFile baseURL:indexURL];
    
}

#pragma mark - WKWebView
//Where the App 'injects' itself.
#pragma mark WKNavigationDelegate
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    //Handle navigation actions...
    switch (navigationAction.navigationType) {
        case WKNavigationTypeLinkActivated:
        case WKNavigationTypeReload:
        case WKNavigationTypeFormSubmitted:
            
            //The problem I think is here...
            decisionHandler(WKNavigationActionPolicyAllow);
            break;
            
        case WKNavigationTypeFormResubmitted:
            decisionHandler(WKNavigationActionPolicyCancel);
            break;
            
            
        default:
            break;
    }
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    //Handle Reponse
    if (navigationResponse.canShowMIMEType) {
        decisionHandler(WKNavigationResponsePolicyAllow);
    } else {
        decisionHandler(WKNavigationResponsePolicyCancel);
    }
    
}

@end
