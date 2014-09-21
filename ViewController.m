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
@property (weak, nonatomic) IBOutlet UIImageView *articleTemperature;
@property (weak, nonatomic) IBOutlet UIImageView *articleThumbnail;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSNumber *temperature = [self.articleDetail objectForKey:@"temperature"];
    if ([temperature intValue] < 100){
        UIImageView *temperatureIcon = [[UIImageView alloc] initWithFrame:CGRectMake(100, 11, 11, 11)];
        temperatureIcon.tag = 53;
        UIImage *temp = [UIImage imageNamed:@"low_temperature"];
        [self.articleTemperature setImage:temp];
    }
    
    self.articleTitle.text = [self.articleDetail objectForKey:@"title"];
    //self.articleTitle.lineBreakMode = UILineBreakModeWordWrap;
    self.webView.delegate = self;
    self.articleTitle.numberOfLines = 0;
    [self.articleThumbnail setImageWithURL:[NSURL URLWithString:[self.articleDetail objectForKey:@"image_url"]]];
    NSString *link = [[NSString alloc]initWithFormat:@"http://www.readability.com/m?url=%@",[self.articleDetail objectForKey:@"link"]];
    //NSString *link = @"http://www.google.com";
    NSURL *url = [NSURL URLWithString:link];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    self.webView.scrollView.delegate = self;
    [self.webView loadRequest:requestObj];

}
-(UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView {
    return nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
