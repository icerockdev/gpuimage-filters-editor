//
//  IRLayersTableViewController.m
//  gpuimage-editor
//
//  Created by Михайлов Алексей on 24.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRLayersTableViewController.h"
#import "IRLayerTableViewCell.h"
#import "IRLayer.h"

@interface IRLayersTableViewController ()<IRLayerTableViewCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property NSMutableArray<IRLayer*>* items;
@property NSIndexPath* imageDestinationIndexPath;

@end

@implementation IRLayersTableViewController

static NSString* kLayerCellReuseIdentifier = @"LayerCell";

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.items = [NSMutableArray array];
  
  self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  self.tableView.estimatedRowHeight = 300;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (IBAction) addLayerButtonPressed:(UIBarButtonItem*)sender {
  [self.tableView beginUpdates];
  
  NSIndexPath* indexPath = [NSIndexPath indexPathForRow:self.items.count
                                              inSection:0];
  
  [self.items addObject:[IRLayer new]];
  [self.tableView insertRowsAtIndexPaths:@[indexPath]
                        withRowAnimation:UITableViewRowAnimationMiddle];
  
  [self.tableView endUpdates];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  IRLayerTableViewCell *cell =
  [tableView dequeueReusableCellWithIdentifier:kLayerCellReuseIdentifier
                                  forIndexPath:indexPath];
  
  cell.delegate = self;
  
  IRLayer* layer = self.items[indexPath.row];
  
  UIImage* image = layer.image;
  if(image == nil) {
    cell.layerImageView.hidden = true;
    cell.filtersConfigurationButton.enabled = false;
    cell.blendConfigurationButton.enabled = false;
    cell.enabledSwitch.enabled = false;
    cell.layerImageView.image = nil;
  } else {
    cell.layerImageView.hidden = false;
    cell.filtersConfigurationButton.enabled = true;
    cell.blendConfigurationButton.enabled = true;
    cell.enabledSwitch.enabled = true;
    cell.layerImageView.image = image;
    
    [cell.layerImageView removeConstraints:cell.layerImageView.constraints];
    [cell.layerImageView addConstraint:
     [NSLayoutConstraint constraintWithItem:cell.layerImageView
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:cell.layerImageView
                                  attribute:NSLayoutAttributeHeight
                                 multiplier:(image.size.width / image.size.height)
                                   constant:0]];
  }
  cell.enabledSwitch.on = layer.enabled;
  
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView
canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath {
  IRLayer *data = self.items[sourceIndexPath.row];
  
  [self.items removeObjectAtIndex:sourceIndexPath.row];
  [self.items insertObject:data atIndex:destinationIndexPath.row];
}

#pragma mark - Layer cell delegate

- (void)layerTableViewCell:(IRLayerTableViewCell *)cell
  selectImageButtonPressed:(UIButton *)button {
  
  NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
  
  if(indexPath == nil) {
    return;
  }
  
  self.imageDestinationIndexPath = indexPath;
  
  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
  
  imagePickerController.delegate = self;
  imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  imagePickerController.allowsEditing = true;
  imagePickerController.modalPresentationStyle = UIModalPresentationPopover;
  imagePickerController.popoverPresentationController.sourceView = button;
  
  [self presentViewController:imagePickerController
                     animated:true
                   completion:nil];
}

- (void)layerTableViewCell:(IRLayerTableViewCell *)cell filtersConfigurationButtonPressed:(UIButton *)button {
  
}

- (void)layerTableViewCell:(IRLayerTableViewCell *)cell blendConfigurationButtonPressed:(UIButton *)button {
  
}

#pragma mark - Image picker delegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [picker dismissViewControllerAnimated:true
                             completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
  
  UIImage *image = info[UIImagePickerControllerOriginalImage];
  
  [picker dismissViewControllerAnimated:true
                             completion:
   ^{
     
     [self.tableView beginUpdates];
     
     self.items[self.imageDestinationIndexPath.row].image = image;
     [self.tableView reloadRowsAtIndexPaths:@[self.imageDestinationIndexPath]
                           withRowAnimation:UITableViewRowAnimationFade];
     
     [self.tableView endUpdates];
   }];
}

@end
