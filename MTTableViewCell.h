//
//  MTTableViewCell.h
//  n4g
//
//  Created by Josh Wiliwonka on 9/13/14.
//  Copyright (c) 2014 Josh Wiliwonka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTTableViewCell : UITableViewCell
@property(weak, nonatomic) IBOutlet UITextView *articleTitle;
@property(weak, nonatomic) IBOutlet UIImageView *articleThumbnail;
@property(weak, nonatomic) IBOutlet UITextView *articleDescription;
@end
