//
//  NSURLSession.m
//  Cats
//
//  Created by Kevin Cleathero on 2017-06-20.
//  Copyright © 2017 Kevin Cleathero. All rights reserved.
//

#import "NSURLSessionModel.h"
#import "PhotoModel.h"

@implementation NSURLSessionModel



+(void)setNSURLSessionTag:(NSMutableArray *)photoArray tag:(NSString *)tag andCollectionView:(UICollectionView *)collectionView{
    
    //NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&has_geo=1&%20format=json&nojsoncallback=1&api_key=28602178605addc1a7730e3c90733b22&tags=cat"];
    
//    NSString *dynamicURL = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&has_geo=1&%20format=json&nojsoncallback=1&api_key=28602178605addc1a7730e3c90733b22&tags=%@", tag];
    
//    NSURL *baseURL = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&has_geo=1&%20format=json&nojsoncallback=1&api_key=28602178605addc1a7730e3c90733b22&tags="];
    
    NSURLQueryItem *queryItem = [[NSURLQueryItem alloc] initWithName:@"method" value:@"flickr.photos.search"];
    NSURLQueryItem *queryItem2 = [[NSURLQueryItem alloc] initWithName:@"has_geo" value:@"1"];
    NSURLQueryItem *queryItem3 = [[NSURLQueryItem alloc] initWithName:@"format" value:@"json"];
    NSURLQueryItem *queryItem4 = [[NSURLQueryItem alloc] initWithName:@"nojsoncallback" value:@"1"];
    NSURLQueryItem *queryItem5 = [[NSURLQueryItem alloc] initWithName:@"api_key" value:@"28602178605addc1a7730e3c90733b22"];
    NSURLQueryItem *queryItem6 = [[NSURLQueryItem alloc] initWithName:@"tags" value:tag];
    
    NSArray *queryItems = [[NSArray alloc] initWithObjects:queryItem, queryItem2, queryItem3,queryItem4,queryItem5,queryItem6, nil];
    
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"https";
    components.host = @"api.flickr.com";
    components.path = @"/services/rest/";
    components.queryItems = queryItems;
    NSURL *url = components.URL;
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error){
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *flickr = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if(jsonError){
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        NSDictionary *photos = flickr[@"photos"][@"photo"];
        
        for(NSDictionary *photo in photos){
            NSLog(@"photoURL: %@", photo[@"farm"]);
            //NSDictionary *photo = photo[@"name"];
            
            NSString *photoURLString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", photo[@"farm"], photo[@"server"], photo[@"id"], photo[@"secret"]];
            
            NSString *imageTitle = photo[@"title"];
            
            NSURL *photoURL = [NSURL URLWithString:photoURLString];
            
            NSNumber *imageId = photo[@"id"];
            
            PhotoModel *photoObject = [[PhotoModel alloc] initWithImageURL:photoURL name:imageTitle andImageId:imageId];
            
            [photoArray addObject:photoObject];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [collectionView reloadData];
        });
        
    }];
    [dataTask resume];
}

@end
