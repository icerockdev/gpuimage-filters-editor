//
//  IRFiltersConfiguratorTableViewCell.h
//  gpuimage-editor
//
//  Created by Aleksey Mikhailov on 06/02/2017.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IRFiltersConfiguratorTableViewCell;
@class IRFilterConfiguration;

@protocol IRFiltersConfiguratorTableViewCellDelegate<NSObject>

- (void)filtersConfiguratorTableViewCell:(IRFiltersConfiguratorTableViewCell*)cell
                          didChangeValue:(float)value
                    atParameterWithIndex:(NSUInteger)index;

@end

@interface IRFiltersConfiguratorTableViewCell : UITableViewCell

@property (nonatomic, weak) id<IRFiltersConfiguratorTableViewCellDelegate> delegate;

- (void)fill:(IRFilterConfiguration*)configuration;

@end
