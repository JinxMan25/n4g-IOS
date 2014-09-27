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
        self.articleDescription = [dictionary objectForKey:@"description"];
        self.user = [dictionary objectForKey:@"user"];
        self.posted = [dictionary objectForKey:@"posted"];
        self.imageURL = [dictionary objectForKey:@"image_url"];
        self.numOfComments = [dictionary objectForKey:@"comments"];
        self.temperature = [dictionary objectForKey:@"temperature"];
        self.link = [dictionary objectForKey:@"link"];
    }
    return self;
}

@end
