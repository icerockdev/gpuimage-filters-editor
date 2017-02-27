//
//  IRFiltersConfiguratorTableViewCell.m
//  gpuimage-editor
//
//  Created by Aleksey Mikhailov on 06/02/2017.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRFiltersConfiguratorTableViewCell.h"
#import "IRFilterDescription.h"
#import "IRFilterParameterDescription.h"
#import "IRFilterConfiguration.h"

@interface IRFiltersConfiguratorTableViewCell()

@property (nonatomic, weak) IBOutlet UILabel* nameLabel;
@property (nonatomic, weak) IBOutlet UIStackView* parametersStackView;

@end

@implementation IRFiltersConfiguratorTableViewCell

- (void)fill:(IRFilterConfiguration*)configuration {
  self.nameLabel.text = configuration.filterDescription.name;

  for(NSInteger i = self.parametersStackView.subviews.count - 1;i >= 0;i--) {
    [self.parametersStackView.subviews[i] removeFromSuperview];
  }

  for(NSInteger i = 0;i < configuration.filterDescription.parametersDescription.count;i++) {
    IRFilterParameterDescription *parameterDescription = configuration.filterDescription.parametersDescription[i];

    UILabel *label = [UILabel new];
    label.text = parameterDescription.name;
    [self.parametersStackView addArrangedSubview:label];

    UISlider *slider = [UISlider new];
    slider.minimumValue = [parameterDescription.minValue floatValue];
    slider.maximumValue = [parameterDescription.maxValue floatValue];
    slider.value = configuration.filterParameters[parameterDescription].floatValue;
    slider.tag = i;
    [slider addTarget:self
               action:@selector(sliderValueChanged:)
     forControlEvents:UIControlEventValueChanged];
    [self.parametersStackView addArrangedSubview:slider];
  }
}

- (void)sliderValueChanged:(UISlider*)slider {
  if([self.delegate respondsToSelector:@selector(filtersConfiguratorTableViewCell:didChangeValue:atParameterWithIndex:)]) {
    [self.delegate filtersConfiguratorTableViewCell:self
                                     didChangeValue:slider.value
                               atParameterWithIndex:(NSUInteger) slider.tag];
  }
}

@end
