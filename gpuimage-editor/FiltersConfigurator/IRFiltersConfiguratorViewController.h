//
//  IRFiltersConfiguratorViewController.h
//  gpuimage-editor
//
//  Created by Aleksey Mikhailov on 06/02/2017.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IRLayerConfiguration;
@class IRPreviewViewController;

@interface IRFiltersConfiguratorViewController : UITableViewController

@property(strong, nonatomic) IRPreviewViewController *previewViewController;
@property IRLayerConfiguration* layerConfiguration;

@end
