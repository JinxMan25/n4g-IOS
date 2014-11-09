//
//  TableViewController.h
//  n4g
//
//  Created by Josh Wiliwonka on 9/13/14.
//  Copyright (c) 2014 Josh Wiliwonka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController{
    NSInteger _currentPage;
    NSInteger _totalPages;
}
@property (nonatomic, strong) UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *hamburger;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *button;


@end
