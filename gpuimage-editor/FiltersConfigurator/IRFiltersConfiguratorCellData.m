//
//  IRFiltersConfiguratorCellData.m
//  gpuimage-editor
//
//  Created by Aleksey Mikhailov on 06/02/2017.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRFiltersConfiguratorCellData.h"
#import "IRFilterDescription.h"
#import "IRFilterParameterDescription.h"

@implementation IRFiltersConfiguratorCellData

- (instancetype)initWithFilterDescription:(IRFilterDescription *)filterDescription {
  self = [super init];
  if(self) {
    _filterDescription = filterDescription;
    _enabled = false;
    _values = [NSMutableArray arrayWithCapacity:filterDescription.parametersDescription.count];

    for(NSUInteger i = 0;i < filterDescription.parametersDescription.count;i++) {
      IRFilterParameterDescription *parameterDescription = filterDescription.parametersDescription[i];
      _values[i] = @(parameterDescription.minValue.floatValue +
          (parameterDescription.maxValue.floatValue - parameterDescription.minValue.floatValue) / 2.0f);
    }
  }
  return self;
}

@end
