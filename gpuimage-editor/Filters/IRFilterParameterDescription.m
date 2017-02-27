//
//  IRFilterParameterDescription.m
//  gpuimage-editor
//
//  Created by Aleksey Mikhailov on 06/02/2017.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRFilterParameterDescription.h"

@implementation IRFilterParameterDescription

+ (IRFilterParameterDescription *)descriptionWithName:(NSString *)name
                                           setterName:(NSString *)setterName
                                             minValue:(NSNumber *)minValue
                                             maxValue:(NSNumber *)maxValue {
  return [[IRFilterParameterDescription alloc] initWithName:name
                                                 setterName:setterName
                                                   minValue:minValue
                                                   maxValue:maxValue];
}

- (instancetype)initWithName:(NSString *)name
                  setterName:(NSString *)setterName
                    minValue:(NSNumber *)minValue
                    maxValue:(NSNumber *)maxValue {
  self = [super init];
  if(self) {
    _name = name;
    _setterName = setterName;
    _minValue = minValue;
    _maxValue = maxValue;
  }
  return self;
}

- (id)copyWithZone:(NSZone *)zone {
  IRFilterParameterDescription* description = [[[self class] allocWithZone:zone] init];
  
  description->_name = self.name;
  description->_setterName = self.setterName;
  description->_minValue = self.minValue;
  description->_maxValue = self.maxValue;
  
  return description;
}

-(BOOL)isEqual:(id)object {
  if([object isKindOfClass:[IRFilterParameterDescription class]]) {
    IRFilterParameterDescription* other = object;
    
    return [other.setterName isEqual:self.setterName];
  }
  return false;
}

@end
