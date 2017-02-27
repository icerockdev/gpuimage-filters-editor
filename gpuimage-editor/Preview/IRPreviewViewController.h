//
//  IRPreviewViewController.h
//  gpuimage-editor
//
//  Created by Aleksey Mikhailov on 06/02/2017.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPUImageFilter;
@class IRLayerConfiguration;

@interface IRPreviewViewController : UIViewController

@property(nonatomic) IRLayerConfiguration* previewLayer;
@property(nonatomic) NSArray<IRLayerConfiguration *> *previewLayers;

@end
