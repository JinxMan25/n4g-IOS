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
#import <UIViewController+ScrollingNavbar.h>
#import "Articles.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UILabel *articleTemperature;
@property (weak, nonatomic) IBOutlet UILabel *user;
@property (weak, nonatomic) IBOutlet UILabel *numOfComments;


//@property (strong, nonatomic) IBOutlet UIImageView *articleThumbnail;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //AMScrollingNavBar
    [self followScrollView: self.webView];
    
    //Alloc activity indicator
    
    UIActivityIndicatorView *actInd =  [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    actInd.color = [UIColor blackColor];
    //actInd.frame = CGRectMake(150, 200, 30, 30);
    actInd.center = CGPointMake(self.webView.center.x, self.webView.center.y-30);
    self.activity = actInd;
    
    //Create instance of Article object
    
    Articles *article = self.articleDetail;
    
    //Set article properties
    
    self.articleTitle.text = article.articleTitle;
    self.articleTemperature.text = article.temperature;
    self.numOfComments.text = article.numOfComments;
    
    //set nav bar title
    
    NSString *user = article.user;
    NSString *time = article.posted;
    NSString *timePosted = [[NSString alloc] initWithFormat :@"%@ %@",time,user];
    self.user.text = timePosted;
    
    //Set delegate to self to allow delegate methods
    
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    
    self.articleTitle.numberOfLines = 0;
    
    //Prepare to send Async request to api
    
    NSString *link = [[NSString alloc]initWithFormat:@"http://api.n4g.samiulhuq.com/articles/get/HTTPreadability.com/m%@", article.link];
    NSURL *url = [NSURL URLWithString:link];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];

    self.webView.scrollView.delegate = self;
    
    [self.webView addSubview:self.activity];
    [self.webView loadRequest:requestObj];

}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [self.activity startAnimating];
}


-(UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView {
    return nil;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activity stopAnimating];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('rdb-header').style.display = 'none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('rdb-article-header').style.display = 'none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('footer').style.display = 'none'"];
}

/*- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"header\").style.display=\"none\";"];
    
}*/


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
