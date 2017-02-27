//
//  IRRender.m
//  gpuimage-editor
//
//  Created by Михайлов Алексей on 26.02.17.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRRender.h"
#import "IRLayerConfiguration.h"
#import "IRFilterConfiguration.h"
#import "IRFilterParameterDescription.h"

#import <GPUImage/GPUImageFilter.h>
#import <GPUImage/GPUImagePicture.h>
#import <GPUImage/GPUImage.h>

@implementation IRRender

- (NSArray<GPUImageFilter*>*)imageFiltersFromConfigurations:(NSArray<IRFilterConfiguration*>*)configurations {
  NSMutableArray<GPUImageFilter*>* filters = [NSMutableArray array];
  
  for(NSUInteger i = 0;i < configurations.count;i++) {
    IRFilterConfiguration* configuration = configurations[i];
    
    if(!configuration.enabled) {
      continue;
    }
    
    [filters addObject:[self imageFilterFromConfiguration:configuration]];
  }
  
  return filters;
}

- (GPUImageFilter*)imageFilterFromConfiguration:(IRFilterConfiguration*)configuration {
  
  NSString* className = configuration.filterDescription.className;
  id filter = [NSClassFromString(className) new];
//  [filtersCode appendString:[NSString stringWithFormat:@"filters[%lu] = [%@ new];\n", (unsigned long)enabledFilterIdx, className]];
  
  for (NSUInteger j = 0; j < configuration.filterDescription.parametersDescription.count; j++) {
    IRFilterParameterDescription *parameterDescription = configuration.filterDescription.parametersDescription[j];
    
    NSString* setterName = parameterDescription.setterName;
    CGFloat value = configuration.filterParameters[parameterDescription].floatValue;
    
    SEL setterSelector = NSSelectorFromString(setterName);
    NSMethodSignature *setterSignature = [[filter class] instanceMethodSignatureForSelector:setterSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:setterSignature];
    [invocation setTarget:filter];
    [invocation setSelector:setterSelector];
    [invocation setArgument:&value atIndex:2];
    [invocation invoke];
    
//    [filtersCode appendString:[NSString stringWithFormat:@"[((%@*)filters[%lu]) %@%f];\n", className, (unsigned long)enabledFilterIdx, setterName, value]];
  }
  
  return filter;
}

- (GPUImagePicture*)renderPictureFromLayer:(IRLayerConfiguration*)layer toOutput:(GPUImageOutput**)output {
  UIImage* image = layer.image;
  NSArray<GPUImageFilter*>* filters = [self imageFiltersFromConfigurations:layer.filters];
  
  GPUImagePicture *imagePicture = [[GPUImagePicture alloc] initWithImage:image];
  GPUImageOutput *imageOutput = imagePicture;
  
  for (NSUInteger i = 0; i < filters.count; i++) {
    GPUImageFilter *filter = filters[i];
    
    [imageOutput addTarget:filter];
    
    imageOutput = filter;
  }
  
  *output = imageOutput;
  
  return imagePicture;
}

- (UIImage*) renderImageFromLayers:(NSArray<IRLayerConfiguration*>*)layers {
  if(layers.count == 0) {
    return nil;
  }
  
  double t1 = CACurrentMediaTime();
  
  UIImage* sourceImage = layers[0].image;
  GPUImageOutput* output;
  GPUImagePicture* picture = [self renderPictureFromLayer:layers[0] toOutput:&output];
  
  for(NSUInteger i = 1; i < layers.count;i++) {
    IRLayerConfiguration* layer = layers[i];
    
    if(!layer.enabled) {
      continue;
    }
    
    GPUImageOutput* layerOutput;
    GPUImagePicture* layerPicture = [self renderPictureFromLayer:layer toOutput:&layerOutput];
    
    GPUImageDifferenceBlendFilter* blendFilter = [GPUImageDifferenceBlendFilter new];
    
    [output addTarget:blendFilter];
    [layerOutput addTarget:blendFilter];
    
    [layerPicture processImage];
    
    output = blendFilter;
  }
  
  [output useNextFrameForImageCapture];
  [picture processImage];
  
  UIImage *currentFilteredFrame;
  if(output == picture) {
    currentFilteredFrame = sourceImage;
  } else {
    currentFilteredFrame = [output imageFromCurrentFramebufferWithOrientation:sourceImage.imageOrientation];
  }
  
  double t2 = CACurrentMediaTime();
  
  NSLog(@"renderImageFromLayers duration %f", (t2-t1));
  
  return currentFilteredFrame;
}

@end
