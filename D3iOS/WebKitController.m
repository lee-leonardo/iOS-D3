//
//  WebKitController.m
//  D3iOS
//
//  Created by Leonardo Lee on 12/18/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "WebKitController.h"

@interface WebKitController ()

@property (nonatomic, strong) WKUserContentController *contentController;
@property (nonatomic, strong) WKUserScript *d3script;

@end

@implementation WebKitController

+(id)sharedInstance
{
    static WebKitController *sharedWebKitController;
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
        _contentController = [[WKUserContentController alloc] init];
        
        
//        *connected = ;
        
//        if (connected) {
//            [NSURL URLWithString:@"http://d3js.org/d3.v3.min.js"];
//        }
        
//        _contentController addScriptMessageHandler:<#(id<WKScriptMessageHandler>)#> name:<#(NSString *)#>
        
    }
    return self;
}



@end
