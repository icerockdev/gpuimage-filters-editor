//
//  IRImagePreviewViewController.m
//  gpuimage-editor
//
//  Created by Михайлов Алексей on 26.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRImagePreviewViewController.h"

@interface IRImagePreviewViewController ()

@property(weak, nonatomic) IBOutlet UIImageView* previewImageView;

@end

@implementation IRImagePreviewViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.previewImageView.image = self.image;
}

- (void)setImage:(UIImage *)image {
  _image = image;
  
  self.previewImageView.image = image;
}

@end
