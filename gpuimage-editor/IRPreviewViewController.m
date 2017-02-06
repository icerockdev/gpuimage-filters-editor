//
//  IRPreviewViewController.m
//  gpuimage-editor
//
//  Created by Aleksey Mikhailov on 06/02/2017.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <GPUImage/GPUImageFilter.h>
#import <GPUImage/GPUImagePicture.h>
#import "IRPreviewViewController.h"

@interface IRPreviewViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, weak) IBOutlet UIImageView *sourceImageView;
@property(nonatomic, weak) IBOutlet UIImageView *resultImageView;
@property(nonatomic, weak) IBOutlet UITextView *configurationTextView;

@end

@implementation IRPreviewViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self configureView];
}

- (IBAction)pressedShareButton:(UIBarButtonItem *)sender {
  UIActivityViewController *activityViewController =
      [[UIActivityViewController alloc] initWithActivityItems:@[self.configurationTextView.text]
                                        applicationActivities:nil];

  activityViewController.modalPresentationStyle = UIModalPresentationPopover;
  activityViewController.popoverPresentationController.barButtonItem = sender;

  [self presentViewController:activityViewController
                     animated:true
                   completion:nil];
}

- (IBAction)pressedCapturePhotoButton:(UIBarButtonItem *)sender {
  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];

  imagePickerController.delegate = self;
  imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  imagePickerController.allowsEditing = true;
  imagePickerController.modalPresentationStyle = UIModalPresentationPopover;
  imagePickerController.popoverPresentationController.barButtonItem = sender;

  [self presentViewController:imagePickerController
                     animated:true
                   completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {

  UIImage *image = info[UIImagePickerControllerOriginalImage];

  self.sourceImageView.image = image;

  [self dismissViewControllerAnimated:true
                           completion:^{
                               [self configureView];
                           }];
}

- (void)setFilters:(NSArray<GPUImageFilter *> *)filters withCode:(NSString *)code {
  _filters = filters;
  _filtersCode = code;

  [self configureView];
}

- (void)configureView {
  UIImage *image = self.sourceImageView.image;
  if (image == nil) {
    self.resultImageView.image = nil;
    self.configurationTextView.text = nil;
    return;
  }

  double t1 = CACurrentMediaTime();

  GPUImagePicture *imagePicture = [[GPUImagePicture alloc] initWithImage:image];
  GPUImageOutput *imageOutput = imagePicture;

  for (NSUInteger i = 0; i < self.filters.count; i++) {
    GPUImageFilter *filter = self.filters[i];

    [imageOutput addTarget:filter];

    imageOutput = filter;
  }

  [imageOutput useNextFrameForImageCapture];

  [imagePicture processImage];

  UIImage *currentFilteredFrame = [imageOutput imageFromCurrentFramebufferWithOrientation:image.imageOrientation];

  double t2 = CACurrentMediaTime();

  self.resultImageView.image = currentFilteredFrame;
  self.configurationTextView.text = [NSString stringWithFormat:@"// render time %f\n%@", (t2 - t1), self.filtersCode];
}

@end
