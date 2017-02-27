//
//  IRLayerConfiguration.m
//  gpuimage-editor
//
//  Created by Михайлов Алексей on 26.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRLayerConfiguration.h"
#import "IRFiltersRepository.h"
#import "IREditorConfiguration.h"

@interface IRLayerConfiguration() {
  NSMutableArray<IRFilterConfiguration*>* _filters;
}

@end

@implementation IRLayerConfiguration

- (instancetype)init {
  self = [super init];
  if(self) {
    IRFiltersRepository* repository = [IRFiltersRepository new];
    NSArray<IRFilterDescription*>* descriptions = repository.filtersDescription;
    NSUInteger descriptionsCount = descriptions.count;
    
    NSMutableArray<IRFilterConfiguration*>* configurations = [NSMutableArray arrayWithCapacity:descriptionsCount];
    for(NSUInteger i = 0;i < descriptionsCount;i++) {
      configurations[i] = [[IRFilterConfiguration alloc] initWithDescription:descriptions[i]];
    }
    
    _filters = configurations;
    _image = nil;
    _enabled = true;
  }
  return self;
}

- (NSArray<IRFilterConfiguration *> *)filters {
  return _filters;
}

- (void)setImage:(UIImage *)image {
  _image = image;
  
  [[NSNotificationCenter defaultCenter] postNotificationName:kEditorConfigurationChanged
                                                      object:nil];
}

- (void)setEnabled:(BOOL)enabled {
  _enabled = enabled;
  
  [[NSNotificationCenter defaultCenter] postNotificationName:kEditorConfigurationChanged
                                                      object:nil];
}

- (void)moveFilterFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
  IRFilterConfiguration *configuration = self.filters[fromIndex];
  [_filters removeObjectAtIndex:fromIndex];
  [_filters insertObject:configuration atIndex:toIndex];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:kEditorConfigurationChanged
                                                      object:nil];
}

@end
