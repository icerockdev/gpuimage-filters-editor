//
//  IRPreviewViewController.h
//  gpuimage-editor
//
//  Created by Aleksey Mikhailov on 06/02/2017.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPUImageFilter;

@interface IRPreviewViewController : UIViewController

@property(nonatomic, copy, readonly) NSArray<GPUImageFilter *> *filters;
@property(nonatomic, readonly) NSString *filtersCode;

- (void)setFilters:(NSArray<GPUImageFilter *> *)filters withCode:(NSString*)code;

@end
