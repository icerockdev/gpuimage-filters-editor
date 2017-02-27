//
//  IRFilterConfiguration.h
//  gpuimage-editor
//
//  Created by Михайлов Алексей on 26.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRFilterDescription.h"

@interface IRFilterConfiguration : NSObject

@property(readonly, nonatomic) IRFilterDescription* filterDescription;
@property(readonly, nonatomic) NSDictionary<IRFilterParameterDescription*, NSNumber*>* filterParameters;
@property(nonatomic) BOOL enabled;

- (instancetype) initWithDescription:(IRFilterDescription*)filterDescription;
- (void) setFilterValue:(NSNumber*)value
           forParameter:(IRFilterParameterDescription*)parameterDescription;

@end
