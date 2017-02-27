//
//  IRLayerConfiguration.h
//  gpuimage-editor
//
//  Created by Михайлов Алексей on 26.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IRFilterConfiguration.h"

@interface IRLayerConfiguration : NSObject

@property(nonatomic) BOOL enabled;
@property(nonatomic) UIImage* image;
@property(readonly, nonatomic) NSArray<IRFilterConfiguration*>* filters;

- (void) moveFilterFromIndex:(NSUInteger)fromIndex
                     toIndex:(NSUInteger)toIndex;

@end
