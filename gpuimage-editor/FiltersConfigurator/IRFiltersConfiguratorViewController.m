//
//  IRFiltersConfiguratorViewController.m
//  gpuimage-editor
//
//  Created by Aleksey Mikhailov on 06/02/2017.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRFiltersConfiguratorViewController.h"
#import "IRFiltersRepository.h"
#import "IRFiltersConfiguratorTableViewCell.h"
#import "IRFilterDescription.h"
#import "IRPreviewViewController.h"
#import "IRFilterParameterDescription.h"
#import "IRFilterConfiguration.h"
#import "IRLayerConfiguration.h"
#import "IRPreviewViewController.h"

@interface IRFiltersConfiguratorViewController () <IRFiltersConfiguratorTableViewCellDelegate>

@end

@implementation IRFiltersConfiguratorViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.estimatedRowHeight = 44.0;
  self.tableView.rowHeight = UITableViewAutomaticDimension;

  [self.tableView setEditing:true];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [[self previewViewController] setPreviewLayer:self.layerConfiguration];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  
  [[self previewViewController] setPreviewLayer:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.layerConfiguration.filters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  IRFiltersConfiguratorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterDescriptionCell"
                                                                             forIndexPath:indexPath];

  IRFilterConfiguration *configuration = self.layerConfiguration.filters[indexPath.row];

  [cell fill:configuration];
  [cell setDelegate:self];
  
  if(configuration.enabled) {
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
  } else {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.layerConfiguration.filters[indexPath.row].enabled = true;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.layerConfiguration.filters[indexPath.row].enabled = false;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
  [self.layerConfiguration moveFilterFromIndex:sourceIndexPath.row
                                       toIndex:destinationIndexPath.row];
}

#pragma mark - IRFiltersConfiguratorTableViewCellDelegate

- (void)filtersConfiguratorTableViewCell:(IRFiltersConfiguratorTableViewCell *)cell
                          didChangeValue:(float)value
                    atParameterWithIndex:(NSUInteger)index {
  NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

  if (indexPath == nil) {
    return;
  }
  
  IRFilterConfiguration* filter = self.layerConfiguration.filters[indexPath.row];
  IRFilterParameterDescription* parameterDescription = filter.filterDescription.parametersDescription[index];
  [filter setFilterValue:@(value) forParameter:parameterDescription];
}

#pragma mark - Private

- (IRPreviewViewController*)previewViewController {
  return (IRPreviewViewController*)[[self.splitViewController.viewControllers lastObject] topViewController];
}

@end
