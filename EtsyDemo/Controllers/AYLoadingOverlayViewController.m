//
//  AYLoadingOverlayViewController.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/28/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "AYLoadingOverlayViewController.h"


@implementation AYLoadingOverlayViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *htmlPath = [NSBundle.mainBundle pathForResource:@"loading_animation" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [self.loadingWebView loadHTMLString:html baseURL:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
