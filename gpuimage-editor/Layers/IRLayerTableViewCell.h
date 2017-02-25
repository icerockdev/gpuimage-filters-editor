//
//  IRLayerTableViewCell.h
//  gpuimage-editor
//
//  Created by Михайлов Алексей on 24.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IRLayerTableViewCell;

@protocol IRLayerTableViewCellDelegate <NSObject>

- (void) layerTableViewCell:(IRLayerTableViewCell*)cell
   selectImageButtonPressed:(UIButton*)button;

- (void) layerTableViewCell:(IRLayerTableViewCell*)cell
filtersConfigurationButtonPressed:(UIButton*)button;

- (void) layerTableViewCell:(IRLayerTableViewCell*)cell
blendConfigurationButtonPressed:(UIButton*)button;

@end

@interface IRLayerTableViewCell : UITableViewCell

@property(weak) IBOutlet UIImageView* layerImageView;
@property(weak) IBOutlet UIButton* selectImageButton;
@property(weak) IBOutlet UIButton* filtersConfigurationButton;
@property(weak) IBOutlet UIButton* blendConfigurationButton;
@property(weak) IBOutlet UISwitch* enabledSwitch;

@property(weak) id<IRLayerTableViewCellDelegate> delegate;

@end
