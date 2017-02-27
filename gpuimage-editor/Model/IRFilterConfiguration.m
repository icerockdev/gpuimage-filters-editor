//
//  IRFilterConfiguration.m
//  gpuimage-editor
//
//  Created by Михайлов Алексей on 26.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRFilterConfiguration.h"
#import "IRFilterParameterDescription.h"
#import "IREditorConfiguration.h"

@interface IRFilterConfiguration() {
  NSMutableDictionary<IRFilterParameterDescription*, NSNumber*>* _filterParameters;
}

@end

@implementation IRFilterConfiguration

- (instancetype)initWithDescription:(IRFilterDescription*)filterDescription {
  self = [super init];
  if(self) {
    NSArray<IRFilterParameterDescription*>* parametersDescription = filterDescription.parametersDescription;
    
    _filterDescription = filterDescription;
    _filterParameters = [NSMutableDictionary dictionaryWithCapacity:parametersDescription.count];
    _enabled = false;
    
    for(NSUInteger i = 0;i < parametersDescription.count;i++) {
      IRFilterParameterDescription* parameterDescription = parametersDescription[i];
      
      _filterParameters[parameterDescription] = @(parameterDescription.minValue.floatValue +
      (parameterDescription.maxValue.floatValue - parameterDescription.minValue.floatValue) / 2.0f);
    }
  }
  return self;
}

- (NSDictionary<IRFilterParameterDescription *,NSNumber *> *)filterParameters {
  return _filterParameters;
}

- (void)setEnabled:(BOOL)enabled {
  _enabled = enabled;
  
  [[NSNotificationCenter defaultCenter] postNotificationName:kEditorConfigurationChanged
                                                      object:nil];
}

- (void)setFilterValue:(NSNumber *)value
          forParameter:(IRFilterParameterDescription *)parameterDescription {
  _filterParameters[parameterDescription] = value;
  
  [[NSNotificationCenter defaultCenter] postNotificationName:kEditorConfigurationChanged
                                                      object:nil];
}

@end
