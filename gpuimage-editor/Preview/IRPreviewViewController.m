//
//  IRPreviewViewController.m
//  gpuimage-editor
//
//  Created by Aleksey Mikhailov on 06/02/2017.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRPreviewViewController.h"
#import "IRFilterPreviewView.h"
#import "IRLayerConfiguration.h"
#import "IRRender.h"
#import "IRImagePreviewViewController.h"
#import "IREditorConfiguration.h"

@interface IRPreviewViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
  IRRender* _render;
}

@property(nonatomic, weak) IBOutlet IRFilterPreviewView *layerPreviewView;
@property(nonatomic, weak) IBOutlet IRFilterPreviewView *layersPreviewView;

@end

@implementation IRPreviewViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.layerPreviewView.hidden = true;
  self.layersPreviewView.hidden = true;
  
  _render = [IRRender new];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(renderResults)
                                               name:kEditorConfigurationChanged
                                             object:nil];
}

- (void)setPreviewLayer:(IRLayerConfiguration *)previewLayer {
  _previewLayer = previewLayer;
  
  if(previewLayer != nil) {
    self.layerPreviewView.hidden = false;
    self.layerPreviewView.sourceImage = previewLayer.image;
    self.layerPreviewView.resultImage = [_render renderImageFromLayers:@[previewLayer]];
  } else {
    self.layerPreviewView.hidden = true;
  }
}

- (void)setPreviewLayers:(NSArray<IRLayerConfiguration *> *)previewLayers {
  _previewLayers = previewLayers;
  
  if(previewLayers != nil && previewLayers.count > 0) {
    self.layersPreviewView.hidden = false;
    self.layersPreviewView.sourceImage = previewLayers[0].image;
    self.layersPreviewView.resultImage = [_render renderImageFromLayers:previewLayers];
  } else {
    self.layersPreviewView.hidden = true;
  }
}

- (void)renderResults {
  if(self.previewLayer != nil) {
    self.layerPreviewView.resultImage = [_render renderImageFromLayers:@[self.previewLayer]];
  }
  if(self.previewLayers != nil) {
    self.layersPreviewView.resultImage = [_render renderImageFromLayers:self.previewLayers];
  }
}

- (IBAction)unwindFromImagePreview:(UIStoryboardSegue*)sender {
  
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if([sender isKindOfClass:[UIGestureRecognizer class]] && [((UIGestureRecognizer*)sender).view isKindOfClass:[UIImageView class]]) {
    UIImageView* imageView = (UIImageView*)((UIGestureRecognizer*)sender).view;
    IRImagePreviewViewController* viewController = segue.destinationViewController;
    
    viewController.image = imageView.image;
  }
}

@end
