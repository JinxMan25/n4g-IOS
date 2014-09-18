//
//  ViewController.m
//  n4g
//
//  Created by Josh Wiliwonka on 9/13/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UIImageView *articleThumbnail;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.articleTitle.text = [self.articleDetail objectForKey:@"title"];
    self.articleTitle.lineBreakMode = UILineBreakModeWordWrap;
    self.webView.delegate = self;
    self.articleTitle.numberOfLines = 0;
    [self.articleThumbnail setImageWithURL:[NSURL URLWithString:[self.articleDetail objectForKey:@"image_url"]]];
    NSString *link = [[NSString alloc]initWithFormat:@"http://www.readability.com/m?url=%@",[self.articleDetail objectForKey:@"link"]];
    //NSString *link = @"http://www.google.com";
    NSURL *url = [NSURL URLWithString:link];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
