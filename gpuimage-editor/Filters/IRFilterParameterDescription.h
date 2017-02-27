//
//  IRFilterParameterDescription.h
//  gpuimage-editor
//
//  Created by Aleksey Mikhailov on 06/02/2017.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IRFilterParameterDescription : NSObject<NSCopying>

@property(readonly) NSString *name;
@property(readonly) NSString *setterName;
@property(readonly) NSNumber *minValue;
@property(readonly) NSNumber *maxValue;

+ (IRFilterParameterDescription *)descriptionWithName:(NSString *)name
                                           setterName:(NSString *)setterName
                                             minValue:(NSNumber *)minValue
                                             maxValue:(NSNumber *)maxValue;

@end
