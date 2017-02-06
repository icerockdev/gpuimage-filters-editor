//
//  IRFilterDescription.h
//  gpuimage-editor
//
//  Created by Aleksey Mikhailov on 06/02/2017.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IRFilterParameterDescription;

@interface IRFilterDescription : NSObject

@property (readonly) NSString* name;
@property (readonly) NSString* className;
@property (readonly) NSArray<IRFilterParameterDescription*>* parametersDescription;

+ (IRFilterDescription *) descriptionWithName:(NSString*)name
                                    className:(NSString*)className
                        parametersDescription:(NSArray<IRFilterParameterDescription*>*)parametersDescription;

@end
