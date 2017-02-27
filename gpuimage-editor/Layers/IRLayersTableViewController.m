//
//  IRLayersTableViewController.m
//  gpuimage-editor
//
//  Created by Михайлов Алексей on 24.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRLayersTableViewController.h"
#import "IRLayerTableViewCell.h"
#import "IRLayerConfiguration.h"
#import "IRFiltersConfiguratorViewController.h"
#import "IRPreviewViewController.h"
#import "IREditorConfiguration.h"

@interface IRLayersTableViewController ()<IRLayerTableViewCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, IREditorConfigurationDelegate>

@property NSIndexPath* imageDestinationIndexPath;
@property IREditorConfiguration* editorConfiguration;

@end

@implementation IRLayersTableViewController

static NSString* kShowFilters = @"filters";
static NSString* kLayerCellReuseIdentifier = @"LayerCell";

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  self.tableView.estimatedRowHeight = 300;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  
  self.editorConfiguration = [IREditorConfiguration new];
  self.editorConfiguration.delegate = self;
}

- (IBAction) addLayerButtonPressed:(UIBarButtonItem*)sender {
  [self.editorConfiguration createLayer];
}

- (void)editorConfiguration:(IREditorConfiguration *)editorConfiguration
                      layer:(IRLayerConfiguration *)layerConfiguration
           didAppendToIndex:(NSUInteger)index {
  [self.tableView beginUpdates];
  
  NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:0];
  [self.tableView insertRowsAtIndexPaths:@[indexPath]
                        withRowAnimation:UITableViewRowAnimationAutomatic];
  
  [self.tableView endUpdates];
}

- (void)editorConfiguration:(IREditorConfiguration *)editorConfiguration
                      layer:(IRLayerConfiguration *)layerConfiguration
           didMoveFromIndex:(NSUInteger)fromIndex
                    toIndex:(NSUInteger)toIndex {
  
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return self.editorConfiguration.layers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  IRLayerTableViewCell *cell =
  [tableView dequeueReusableCellWithIdentifier:kLayerCellReuseIdentifier
                                  forIndexPath:indexPath];
  
  cell.delegate = self;
  
  IRLayerConfiguration* layer = self.editorConfiguration.layers[indexPath.row];
  
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
  [self.editorConfiguration moveLayerFromIndex:sourceIndexPath.row
                                       toIndex:destinationIndexPath.row];
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
  NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
  
  if(indexPath == nil) {
    return;
  }
  
  [self performSegueWithIdentifier:kShowFilters
                            sender:indexPath];
}

- (void)layerTableViewCell:(IRLayerTableViewCell *)cell blendConfigurationButtonPressed:(UIButton *)button {
  
}

#pragma mark - seque

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if([segue.destinationViewController isKindOfClass:[IRFiltersConfiguratorViewController class]]) {
    IRFiltersConfiguratorViewController* viewController = segue.destinationViewController;
    NSIndexPath* indexPath = sender;
    
    viewController.layerConfiguration = self.editorConfiguration.layers[indexPath.row];
  }
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
     NSUInteger index = self.imageDestinationIndexPath.row;
     self.editorConfiguration.layers[index].image = image;
     
     [self.tableView beginUpdates];
     
     [self.tableView reloadRowsAtIndexPaths:@[self.imageDestinationIndexPath]
                           withRowAnimation:UITableViewRowAnimationFade];
     
     [self.tableView endUpdates];
   }];
}

- (IRPreviewViewController*)previewViewController {
  return (IRPreviewViewController*)[[self.splitViewController.viewControllers lastObject] topViewController];
}

@end
