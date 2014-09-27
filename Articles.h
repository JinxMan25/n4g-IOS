//
//  Articles.h
//  n4g
//
//  Created by Josh Wiliwonka on 9/27/14.
//  Copyright (c) 2014 Josh Wiliwonka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Articles : NSObject

@property (nonatomic, copy) NSString *articleTitle;
@property (nonatomic, copy) NSString *articleDescription;
@property (nonatomic, copy) NSString *user;
@property (nonatomic, copy) NSString *posted;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *numOfComments;
@property (nonatomic, copy) NSString *temperature;
@property (nonatomic, copy) NSString *link;

- (id) initWithDictionary:(NSDictionary *)dictionary;

@end
