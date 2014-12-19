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

@property (nonatomic, strong) WebKitController *wkController;

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
        WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(10.0, 10.0, self.view.frame.size.width - 20, self.view.frame.size.height - 20) configuration:_wkController.config];
        
        wkWebView.UIDelegate = self;
        wkWebView.navigationDelegate = self;
    
    
    [self.view addSubview:wkWebView];
    
    
#else
    
    //UIWebView
    
#endif
    
}

@end
