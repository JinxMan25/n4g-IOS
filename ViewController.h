//
//  ViewController.h
//  n4g
//
//  Created by Josh Wiliwonka on 9/13/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property(strong, nonatomic) NSDictionary *articleDetail;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
