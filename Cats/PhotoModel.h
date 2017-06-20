//
//  PhotoModel.h
//  Cats
//
//  Created by Kevin Cleathero on 2017-06-19.
//  Copyright © 2017 Kevin Cleathero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoModel : NSObject

@property (nonatomic) UIImage *image;
@property (nonatomic) NSURL *imageURL;
@property (nonatomic) NSString *name;

- (instancetype)initWithImageURL:(NSURL *)imageurl andName:(NSString *)name;

@end
