//
//  ViewController.m
//  Cats
//
//  Created by Kevin Cleathero on 2017-06-19.
//  Copyright © 2017 Kevin Cleathero. All rights reserved.
//

#import "ViewController.h"
#import "PhotoModel.h"
#import "CustomImageCell.h"
#import "DetailsViewController.h"



@interface ViewController ()

@property (nonatomic) NSMutableArray *photos;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSIndexPath *indexPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //Make the GET request using NSURLSession
    //Request all photos tagged with cats using an NSURLSession.
    //Use a JSON Parser to convert/deserialize the JSON string into an NSDictionary.
    self.photos = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=28602178605addc1a7730e3c90733b22&tags=cat"];
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
        //https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
        //https://farm1.staticflickr.com/582/22992326269_b6c8fdff52.jpg
        //@"farm"
        //@"server"
        //@"id" + @"secret"
        
        NSDictionary *photos = flickr[@"photos"][@"photo"];
        
        for(NSDictionary *photo in photos){
            NSLog(@"photoURL: %@", photo[@"farm"]);
            //NSDictionary *photo = photo[@"name"];
            
            NSString *photoURLString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", photo[@"farm"], photo[@"server"], photo[@"id"], photo[@"secret"]];
            
            NSString *imageTitle = photo[@"title"];
            
            NSURL *photoURL = [NSURL URLWithString:photoURLString];
            
            NSNumber *imageId = photo[@"id"];
            
            PhotoModel *photoObject = [[PhotoModel alloc] initWithImageURL:photoURL name:imageTitle andImageId:imageId];
            
            [self.photos addObject:photoObject];
        
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
    }];
    [dataTask resume];

    //https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=28602178605addc1a7730e3c90733b22&tags=cat
    
    //https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
    //https://farm1.staticflickr.com/582/22992326269_b6c8fdff52.jpg
    
    
    
}



#pragma Mark - collectionView DataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     return self.photos.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return  1;
}


#pragma Mark - collectionView Delegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CustomImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    //need to pass some data
    
    PhotoModel *photoObject = self.photos[indexPath.row];
    
    //Add a UIImage property to the Photo object to store the image once it's downloaded. Use this property to check if the image has already been downloaded and use it if it has.
    
    cell.delegate = self;
    
    if(photoObject.image == nil){
        NSData *data = [NSData dataWithContentsOfURL:photoObject.imageURL];
        UIImage *result = [UIImage imageWithData:data];
        cell.imageViewCell.image = result;
        photoObject.image = result;
    } else{
        cell.imageViewCell.image = photoObject.image;
        cell.imageViewLabel.text = photoObject.name;
    }

    

    //cell.imgSmallabel.text = imageObject.imgDescription;
    
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"segue"]){
        PhotoModel *photoObject = [self.photos objectAtIndex:self.indexPath.row];
        DetailsViewController *controller = [segue destinationViewController];
        [controller setDetailItem:photoObject];
    }
}



-(void)collectionCellDidTap:(CustomImageCell *)cell{
    self.indexPath = [self.collectionView indexPathForCell:cell];
    [self performSegueWithIdentifier:@"segue" sender:self];
}



@end
