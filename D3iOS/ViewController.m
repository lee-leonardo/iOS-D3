//
//  ViewController.m
//  D3iOS
//
//  Created by Leonardo Lee on 12/18/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(self.view.center.x, self.view.center.y, self.view.frame.size.width, self.view.frame.size.height) configuration:<#(WKWebViewConfiguration *)#>
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
//    [self presentViewController:nil animated:YES completion:^{
//        //
//    }];
    
    
    
    [UIView animateWithDuration:1.0 delay:0.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [[self view] addSubview:_webView];
                         
                     } completion:^(BOOL finished) {
                         
                     }];
    
    
}

@end
