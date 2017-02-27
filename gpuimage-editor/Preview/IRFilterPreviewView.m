//
//  IRFilterPreviewView.m
//  gpuimage-editor
//
//  Created by Михайлов Алексей on 26.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRFilterPreviewView.h"

@interface IRFilterPreviewView()

@property(weak, nonatomic) IBOutlet UIImageView* sourceImageView;
@property(weak, nonatomic) IBOutlet UIImageView* resultImageView;

@end

@implementation IRFilterPreviewView

- (void)setSourceImage:(UIImage *)sourceImage {
  self.sourceImageView.image = sourceImage;
}

- (void)setResultImage:(UIImage *)resultImage {
  self.resultImageView.image = resultImage;
}

@end
