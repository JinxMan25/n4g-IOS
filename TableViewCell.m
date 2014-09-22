//
//  TableViewCell.m
//  n4g
//
//  Created by Josh Wiliwonka on 9/21/14.
//  Copyright (c) 2014 Josh Wiliwonka. All rights reserved.
//

#import "TableViewCell.h"
#import "ViewController.h"

@implementation TableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Helpers
        CGSize size = self.contentView.frame.size;
        
        // Initialize Main Label
        self.articleTitle = [[UILabel alloc] initWithFrame:CGRectMake(76, 0, 220, 35)];
        
        // Configure Main Label
        [self.articleTitle setFont:[UIFont boldSystemFontOfSize:8.0]];
        
        
        // Add Main Label to Content View
        [self.contentView addSubview:self.articleTitle];
    }
    
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
