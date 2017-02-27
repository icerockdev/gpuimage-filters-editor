//
//  IREditorConfiguration.m
//  gpuimage-editor
//
//  Created by Михайлов Алексей on 26.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IREditorConfiguration.h"
#import "IRLayerConfiguration.h"

static NSString* kEditorConfigurationChanged = @"EditorConfigurationChanged";

@interface IREditorConfiguration() {
  NSMutableArray<IRLayerConfiguration*>* _layers;
}

@end

@implementation IREditorConfiguration

- (instancetype)init {
  self = [super init];
  if(self) {
    _layers = [NSMutableArray array];
  }
  return self;
}

- (NSArray<IRLayerConfiguration *> *)layers {
  return _layers;
}

- (void)createLayer {
  IRLayerConfiguration* layerConfiguration = [IRLayerConfiguration new];
  NSUInteger index = _layers.count;
  
  [_layers addObject:layerConfiguration];
  
  [self.delegate editorConfiguration:self
                               layer:layerConfiguration
                    didAppendToIndex:index];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:kEditorConfigurationChanged
                                                      object:nil];
}

- (void)moveLayerFromIndex:(NSUInteger)fromIndex
                   toIndex:(NSUInteger)toIndex {
  IRLayerConfiguration *data = _layers[fromIndex];
  
  [_layers removeObjectAtIndex:fromIndex];
  [_layers insertObject:data atIndex:toIndex];
  
  [self.delegate editorConfiguration:self
                               layer:data
                    didMoveFromIndex:fromIndex
                             toIndex:toIndex];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:kEditorConfigurationChanged
                                                      object:nil];
}

@end
