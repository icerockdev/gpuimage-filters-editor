//
//  IREditorConfiguration.h
//  gpuimage-editor
//
//  Created by Михайлов Алексей on 26.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IRLayerConfiguration;
@class IREditorConfiguration;

static NSString* kEditorConfigurationChanged;

@protocol IREditorConfigurationDelegate <NSObject>

- (void) editorConfiguration:(IREditorConfiguration*)editorConfiguration
                       layer:(IRLayerConfiguration*)layerConfiguration
            didAppendToIndex:(NSUInteger)index;

- (void) editorConfiguration:(IREditorConfiguration*)editorConfiguration
                       layer:(IRLayerConfiguration*)layerConfiguration
            didMoveFromIndex:(NSUInteger)fromIndex
                     toIndex:(NSUInteger)toIndex;

@end

@interface IREditorConfiguration : NSObject

@property(readonly, nonatomic) NSArray<IRLayerConfiguration*>* layers;
@property id<IREditorConfigurationDelegate> delegate;

- (void) createLayer;
- (void) moveLayerFromIndex:(NSUInteger)fromIndex
                    toIndex:(NSUInteger)toIndex;

@end
