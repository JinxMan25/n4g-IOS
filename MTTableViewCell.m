//
//  MTTableViewCell.m
//  n4g
//
//  Created by Josh Wiliwonka on 9/13/14.
//  Copyright (c) 2014 Josh Wiliwonka. All rights reserved.
//

#import "MTTableViewCell.h"
#import "ViewController.h"

@implementation MTTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Helpers
        CGSize size = self.contentView.frame.size;
        
        // Initialize Main Label
        self.articleTitle = [[UITextView alloc] initWithFrame:CGRectMake(8.0, 8.0, size.width - 16.0, size.height - 10.0)];
        [self.articleTitle setUserInteractionEnabled:NO];
        
        // Configure Main Label
                // Add Main Label to Content View
        [self.contentView addSubview:self.articleTitle];
    }
    
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
