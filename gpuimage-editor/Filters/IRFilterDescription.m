//
//  IRFilterDescription.m
//  gpuimage-editor
//
//  Created by Aleksey Mikhailov on 06/02/2017.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRFilterDescription.h"

@implementation IRFilterDescription

+ (IRFilterDescription *) descriptionWithName:(NSString*)name
                                    className:(NSString*)className
                        parametersDescription:(NSArray<IRFilterParameterDescription*>*)parametersDescription {
  return [[IRFilterDescription alloc] initWithName:name
                                         className:className
                             parametersDescription:parametersDescription];
}

- (instancetype) initWithName:(NSString*)name
                    className:(NSString*)className
        parametersDescription:(NSArray<IRFilterParameterDescription*>*)parametersDescription {
  self = [super init];
  if(self) {
    _name = name;
    _className = className;
    _parametersDescription = [parametersDescription copy];
  }
  return self;
}

@end
