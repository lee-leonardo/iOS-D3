//
//  ViewController.m
//  D3iOS
//
//  Created by Leonardo Lee on 12/18/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ViewController

#pragma mark - UIView
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    _webView.delegate = self;
//    _webView loadRequest:<#(NSURLRequest *)#>

    [self setupWebView];
    
    [self.view addSubview:_webView];

}

#pragma mark Set Up
-(void)setupWebView
{
//    Same idea as this, however this will be replaced directly by the html page. No linkage to the D3.
//    NSString *d3Lib = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"d3.min" withExtension:@".js"] encoding:NSUTF8StringEncoding error:NULL];
    
    NSString *index = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *startPage = [NSURL fileURLWithPath:index];
    [_webView loadHTMLString:@"index.html" baseURL:startPage];
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
