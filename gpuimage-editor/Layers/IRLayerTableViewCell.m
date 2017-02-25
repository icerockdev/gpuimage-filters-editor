//
//  IRLayerTableViewCell.m
//  gpuimage-editor
//
//  Created by Михайлов Алексей on 24.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRLayerTableViewCell.h"

@implementation IRLayerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction) selectImageButtonPressed:(UIButton*)sender {
  [self.delegate layerTableViewCell:self
           selectImageButtonPressed:sender];
}

- (IBAction) filtersConfigurationButtonPressed:(UIButton*)sender {
  [self.delegate layerTableViewCell:self
  filtersConfigurationButtonPressed:sender];
}

- (IBAction) blendConfigurationButtonPressed:(UIButton*)sender {
  [self.delegate layerTableViewCell:self
    blendConfigurationButtonPressed:sender];
}

@end
