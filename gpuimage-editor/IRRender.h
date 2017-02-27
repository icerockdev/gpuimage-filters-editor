//
//  IRRender.h
//  gpuimage-editor
//
//  Created by Михайлов Алексей on 26.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IRLayerConfiguration;

@interface IRRender : NSObject

- (UIImage*) renderImageFromLayers:(NSArray<IRLayerConfiguration*>*)layers;

@end
