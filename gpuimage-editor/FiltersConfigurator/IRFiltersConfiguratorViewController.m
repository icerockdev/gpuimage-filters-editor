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
#import "IRFiltersConfiguratorCellData.h"
#import "IRFilterDescription.h"
#import "IRPreviewViewController.h"
#import "IRFilterParameterDescription.h"

@interface IRFiltersConfiguratorViewController () <IRFiltersConfiguratorTableViewCellDelegate>

@property(nonatomic) NSMutableArray<IRFiltersConfiguratorCellData *> *tableData;

@end

@implementation IRFiltersConfiguratorViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  IRFiltersRepository *filtersRepository = [IRFiltersRepository new];
  self.tableData = [NSMutableArray arrayWithCapacity:filtersRepository.filtersDescription.count];

  for (NSUInteger i = 0; i < filtersRepository.filtersDescription.count; i++) {
    IRFilterDescription *filterDescription = filtersRepository.filtersDescription[i];
    self.tableData[i] = [[IRFiltersConfiguratorCellData alloc] initWithFilterDescription:filterDescription];
  }

  self.tableView.estimatedRowHeight = 44.0;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.allowsMultipleSelectionDuringEditing = true;

  [self.tableView setEditing:true];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  IRFiltersConfiguratorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterDescriptionCell"
                                                                             forIndexPath:indexPath];

  IRFiltersConfiguratorCellData *data = self.tableData[indexPath.row];

  [cell fill:data];
  [cell setDelegate:self];

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.tableData[indexPath.row].enabled = true;

  [self updateConfiguration];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.tableData[indexPath.row].enabled = false;

  [self updateConfiguration];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
  IRFiltersConfiguratorCellData *data = self.tableData[sourceIndexPath.row];
  [self.tableData removeObjectAtIndex:sourceIndexPath.row];
  [self.tableData insertObject:data atIndex:destinationIndexPath.row];

  [self updateConfiguration];
}

#pragma mark - IRFiltersConfiguratorTableViewCellDelegate

- (void)filtersConfiguratorTableViewCell:(IRFiltersConfiguratorTableViewCell *)cell
                          didChangeValue:(float)value
                    atParameterWithIndex:(NSUInteger)index {
  NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

  if (indexPath == nil) {
    return;
  }

  self.tableData[indexPath.row].values[index] = @(value);

  [self updateConfiguration];
}

#pragma mark - Private

- (void)updateConfiguration {
  NSMutableArray<GPUImageFilter *> *filters = [NSMutableArray new];
  NSMutableString* filtersCode = [NSMutableString stringWithString:@"NSMutableArray<GPUImageFilter*>* filters = [NSMutableArray array];\n"];
  NSUInteger enabledFilterIdx = 0;

  for (NSUInteger i = 0; i < self.tableData.count; i++) {
    if (!self.tableData[i].enabled) {
      continue;
    }

    NSString* className = self.tableData[i].filterDescription.className;
    id filter = [NSClassFromString(className) new];
    [filtersCode appendString:[NSString stringWithFormat:@"filters[%lu] = [%@ new];\n", (unsigned long)enabledFilterIdx, className]];

    for (NSUInteger j = 0; j < self.tableData[i].filterDescription.parametersDescription.count; j++) {
      IRFilterParameterDescription *parameterDescription = self.tableData[i].filterDescription.parametersDescription[j];

      NSString* setterName = parameterDescription.setterName;
      CGFloat value = self.tableData[i].values[j].floatValue;

      SEL setterSelector = NSSelectorFromString(setterName);
      NSMethodSignature *setterSignature = [[filter class] instanceMethodSignatureForSelector:setterSelector];
      NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:setterSignature];
      [invocation setTarget:filter];
      [invocation setSelector:setterSelector];
      [invocation setArgument:&value atIndex:2];
      [invocation invoke];

      [filtersCode appendString:[NSString stringWithFormat:@"[((%@*)filters[%lu]) %@%f];\n", className, (unsigned long)enabledFilterIdx, setterName, value]];
    }

    [filters addObject:filter];

    enabledFilterIdx++;
  }

  UIViewController *viewController = [(UINavigationController *) [self.splitViewController.viewControllers lastObject] topViewController];
  if ([viewController isKindOfClass:[IRPreviewViewController class]]) {
    IRPreviewViewController *previewViewController = (IRPreviewViewController *) viewController;
    [previewViewController setFilters:filters withCode:filtersCode];
  }
}

@end
