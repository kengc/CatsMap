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
@property (nonatomic) NSString *views;
@property (nonatomic) NSNumber *imageId;

- (instancetype)initWithImageURL:(NSURL *)imageurl name:(NSString *)name andImageId:(NSNumber *)imageId;

@end
