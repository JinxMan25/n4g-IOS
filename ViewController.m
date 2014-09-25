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
@property (weak, nonatomic) IBOutlet UILabel *articleTemperature;
@property (weak, nonatomic) IBOutlet UILabel *user;
@property (weak, nonatomic) IBOutlet UILabel *numOfComments;
@property (weak, nonatomic) IBOutlet UILabel *posted;

//@property (strong, nonatomic) IBOutlet UIImageView *articleThumbnail;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.articleTitle.text = [self.articleDetail objectForKey:@"title"];
    
    self.articleTemperature.text = [self.articleDetail objectForKey:@"temperature"];
    
    self.numOfComments.text = [self.articleDetail objectForKey:@"comments"];
    
    NSString *user = [self.articleDetail objectForKey:@"user"];
    NSString *time = [self.articleDetail objectForKey:@"posted"];
    NSString *timePosted = [[NSString alloc] initWithFormat :@"%@ %@",time,user];
    
    self.user.text = timePosted;
    
    self.webView.delegate = self;
    self.articleTitle.numberOfLines = 0;
    //[self.articleThumbnail setImageWithURL:[NSURL URLWithString:[self.articleDetail objectForKey:@"image_url"]]];
    NSString *link = [[NSString alloc]initWithFormat:@"http://www.readability.com/m?url=%@",[self.articleDetail objectForKey:@"link"]];
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
