//
//  IRFiltersConfiguratorCellData.h
//  gpuimage-editor
//
//  Created by Aleksey Mikhailov on 06/02/2017.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IRFilterDescription;

@interface IRFiltersConfiguratorCellData: NSObject

@property (nonatomic, readonly) IRFilterDescription *filterDescription;
@property bool enabled;
@property NSMutableArray<NSNumber*>* values;

- (instancetype)initWithFilterDescription:(IRFilterDescription *)filterDescription;

@end
