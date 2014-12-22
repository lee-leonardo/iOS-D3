//
//  ViewController.m
//  D3iOS
//
//  Created by Leonardo Lee on 12/18/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//
//
//Article to get more information on the execution of Javascript in Objective-C
//http://stevenpsmith.wordpress.com/2011/01/20/executing-javascript-from-objective-c-in-an-ios-app/

#import "PreIOS8ViewController.h"
//#import "WebViewJavascriptBridge.h" //This would be to have Javascript Scripts run in the UIWebView? I am not too sure with the addition of -executeJavascriptFunction

@interface PreIOS8ViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation PreIOS8ViewController

#pragma mark - UIView
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupWebView]; //This version has a longer (much longer! loading time).
    [self.view addSubview:_webView];
}

#pragma mark - Set Up
-(void)setupWebView
{
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    _webView.delegate = self;
    //    _webView.suppressesIncrementalRendering = NO; //This will be something one should change so that SVGs do not kill the processor.
    

//    Same idea as this, however this will be replaced directly by the html page. No linkage to the D3.
//    NSString *d3Lib = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"d3.min" withExtension:@".js"] encoding:NSUTF8StringEncoding error:NULL];
    
    NSString *index = [[NSBundle mainBundle] pathForResource:@"simpleExample" ofType:@"html"];
    NSURL *startPage = [NSURL fileURLWithPath:index];
    NSString *page = [NSString stringWithContentsOfURL:startPage encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:page baseURL:startPage];
    
    /*
        An alternate way:
        [_webView loadHTMLString:@"" baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
     */
}

#pragma mark - Javascript
-(void)executeJavascriptScriptFunction:(NSString *)functionName withArguments:(NSString *)arguments
{
    /*
     To Execute a JS script:
     NSString *arguments = [[NSString alloc] init];
     NSString *function = [NSString stringWithFormat:@"function(%@)", arguments];
     NSString *result = [_webView stringByEvaluatingJavaScriptFromString:function];
     */
    
    NSString *function = [NSString stringWithFormat:@"%@(%@)", functionName, arguments];
    NSString *result = [_webView stringByEvaluatingJavaScriptFromString:function];
}

#pragma mark Listener
/*
    This is where we can inject Javascript code. By a listener much like the WebKit (except we write it manually here).
 */

-(void)addListener:(id)sender
{
//    NSString *d3Lib = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"d3.min" withExtension:@".js"] encoding:NSUTF8StringEncoding error:NULL];
//    NSString *result = [_webView stringByEvaluatingJavaScriptFromString:<#(NSString *)#>];
    
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    //Need to implement this.
    return YES;
}

@end
