//
//  Articles.m
//  n4g
//
//  Created by Josh Wiliwonka on 9/27/14.
//  Copyright (c) 2014 Josh Wiliwonka. All rights reserved.
//

#import "Articles.h"

@implementation Articles

- (id) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.articleTitle = [dictionary objectForKey:@"title"];
    }
    return self;
}

@end
