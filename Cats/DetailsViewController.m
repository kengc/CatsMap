//
//  DetailsViewController.m
//  Cats
//
//  Created by Kevin Cleathero on 2017-06-19.
//  Copyright © 2017 Kevin Cleathero. All rights reserved.
//

#import "DetailsViewController.h"


@interface DetailsViewController ()

@end

@implementation DetailsViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Update the view. TWICE to be safe
    [self configureView];
}

- (void)setDetailItem:(PhotoModel *)newDetailItem {
    //if (self.detailItem != newDetailItem) {
    _photoObject = newDetailItem;
    
    
    // Update the view. TWICE to be safe
    [self configureView];
    //}
}


- (void)configureView {
    // Update the user interface for the detail item.
    if (self.photoObject) {
        
        [self.imageViewDetail setImage:self.photoObject.image];
        //self.imageViewDetail.image = self.detailItem.imageCell;
        //self.imageViewDetail.image = [self.detailItem imageCell];
        
        self.imageNameLabel.text = self.photoObject.name;
        //self.textViewDetail.text = [self.detailItem imgDescription ];
        
    }
}


- (IBAction)ButtonAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
