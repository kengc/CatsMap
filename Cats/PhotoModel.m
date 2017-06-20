//
//  PhotoModel.m
//  Cats
//
//  Created by Kevin Cleathero on 2017-06-19.
//  Copyright © 2017 Kevin Cleathero. All rights reserved.
//

#import "PhotoModel.h"


@implementation PhotoModel

- (instancetype)initWithImageURL:(NSURL *)imageurl andName:(NSString *)name
{
    self = [super init];
    if (self) {
        _imageURL = imageurl;
        _name = name;
    }
    return self;
}

@end
