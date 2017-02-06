//
//  IRFiltersRepository.m
//  gpuimage-editor
//
//  Created by Aleksey Mikhailov on 06/02/2017.
//  Copyright © 2017 IceRock Development. All rights reserved.
//

#import "IRFiltersRepository.h"
#import "IRFilterDescription.h"
#import "IRFilterParameterDescription.h"

@implementation IRFiltersRepository

- (instancetype)init {
  self = [super init];
  if(self) {
    _filtersDescription = @[
        [IRFilterDescription descriptionWithName:@"Brightness"
                                       className:@"GPUImageBrightnessFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"brightness"
                                                                      setterName:@"setBrightness:"
                                                                        minValue:@(-1.0)
                                                                        maxValue:@(1.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Exposure"
                                       className:@"GPUImageExposureFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"exposure"
                                                                      setterName:@"setExposure:"
                                                                        minValue:@(-10.0)
                                                                        maxValue:@(10.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Contrast"
                                       className:@"GPUImageContrastFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"contrast"
                                                                      setterName:@"setContrast:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(4.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Saturation"
                                       className:@"GPUImageSaturationFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"saturation"
                                                                      setterName:@"setSaturation:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(2.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Gamma"
                                       className:@"GPUImageGammaFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"gamma"
                                                                      setterName:@"setGamma:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(3.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"RGB"
                                       className:@"GPUImageRGBFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"red"
                                                                      setterName:@"setRed:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(1.0)],
                               [IRFilterParameterDescription descriptionWithName:@"green"
                                                                      setterName:@"setGreen:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(1.0)],
                               [IRFilterParameterDescription descriptionWithName:@"blue"
                                                                      setterName:@"setBlue:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(1.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Hue"
                                       className:@"GPUImageHueFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"hue"
                                                                      setterName:@"setHue:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(360.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"White balance"
                                       className:@"GPUImageWhiteBalanceFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"temperature"
                                                                      setterName:@"setTemperature:"
                                                                        minValue:@(4000.0)
                                                                        maxValue:@(7000.0)],
                               [IRFilterParameterDescription descriptionWithName:@"tint"
                                                                      setterName:@"setTint:"
                                                                        minValue:@(-200.0)
                                                                        maxValue:@(200.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Highlight shadows"
                                       className:@"GPUImageHighlightShadowFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"shadows"
                                                                      setterName:@"setShadows:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(1.0)],
                               [IRFilterParameterDescription descriptionWithName:@"highlights"
                                                                      setterName:@"setHighlights:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(1.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Amatorka"
                                       className:@"GPUImageAmatorkaFilter"
                           parametersDescription:@[]
        ],
        [IRFilterDescription descriptionWithName:@"Miss Etikate"
                                       className:@"GPUImageMissEtikateFilter"
                           parametersDescription:@[]
        ],
        [IRFilterDescription descriptionWithName:@"Soft Elegance"
                                       className:@"GPUImageSoftEleganceFilter"
                           parametersDescription:@[]
        ],
        [IRFilterDescription descriptionWithName:@"Color invert"
                                       className:@"GPUImageColorInvertFilter"
                           parametersDescription:@[]
        ],
        [IRFilterDescription descriptionWithName:@"Grayscale"
                                       className:@"GPUImageGrayscaleFilter"
                           parametersDescription:@[]
        ],
        [IRFilterDescription descriptionWithName:@"Monochrome"
                                       className:@"GPUImageMonochromeFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"intensity"
                                                                      setterName:@"setIntensity:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(1.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Haze"
                                       className:@"GPUImageHazeFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"distance"
                                                                      setterName:@"setDistance:"
                                                                        minValue:@(-0.3)
                                                                        maxValue:@(0.3)],
                               [IRFilterParameterDescription descriptionWithName:@"slope"
                                                                      setterName:@"setSlope:"
                                                                        minValue:@(-0.3)
                                                                        maxValue:@(0.3)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Sepia"
                                       className:@"GPUImageSepiaFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"intensity"
                                                                      setterName:@"setIntensity:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(1.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Luminance threshold"
                                       className:@"GPUImageLuminanceThresholdFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"threshold"
                                                                      setterName:@"setThreshold:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(1.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Adaptive threshold"
                                       className:@"GPUImageAdaptiveThresholdFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"blurRadiusInPixels"
                                                                      setterName:@"setBlurRadiusInPixels:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(16.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Average luminance threshold"
                                       className:@"GPUImageAverageLuminanceThresholdFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"thresholdMultiplier"
                                                                      setterName:@"setThresholdMultiplier:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(16.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Sharpen"
                                       className:@"GPUImageSharpenFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"sharpness"
                                                                      setterName:@"setSharpness:"
                                                                        minValue:@(-4.0)
                                                                        maxValue:@(4.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Unsharp mask"
                                       className:@"GPUImageUnsharpMaskFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"blurRadiusInPixels"
                                                                      setterName:@"setBlurRadiusInPixels:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(8.0)],
                               [IRFilterParameterDescription descriptionWithName:@"intensity"
                                                                      setterName:@"setIntensity:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(8.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Median"
                                       className:@"GPUImageMedianFilter"
                           parametersDescription:@[]
        ],
        [IRFilterDescription descriptionWithName:@"Crosshatch"
                                       className:@"GPUImageCrosshatchFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"crossHatchSpacing"
                                                                      setterName:@"setCrossHatchSpacing:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(0.5)],
                               [IRFilterParameterDescription descriptionWithName:@"lineWidth"
                                                                      setterName:@"setLineWidth:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(0.5)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Sketch"
                                       className:@"GPUImageSketchFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"edgeStrength"
                                                                      setterName:@"setEdgeStrength:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(2.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Toon"
                                       className:@"GPUImageToonFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"threshold"
                                                                      setterName:@"setThreshold:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(1.0)],
                               [IRFilterParameterDescription descriptionWithName:@"quantizationLevels"
                                                                      setterName:@"setQuantizationLevels:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(20.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Smooth toon"
                                       className:@"GPUImageSmoothToonFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"blurRadiusInPixels"
                                                                      setterName:@"setBlurRadiusInPixels:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(2.0)],
                               [IRFilterParameterDescription descriptionWithName:@"threshold"
                                                                      setterName:@"setThreshold:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(1.0)],
                               [IRFilterParameterDescription descriptionWithName:@"quantizationLevels"
                                                                      setterName:@"setQuantizationLevels:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(20.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Emboss"
                                       className:@"GPUImageEmbossFilter"
                           parametersDescription:@[
                               [IRFilterParameterDescription descriptionWithName:@"intensity"
                                                                      setterName:@"setIntensity:"
                                                                        minValue:@(0.0)
                                                                        maxValue:@(4.0)]
                           ]
        ],
        [IRFilterDescription descriptionWithName:@"Kuwahara"
                                       className:@"GPUImageKuwaharaRadius3Filter"
                           parametersDescription:@[]
        ]
    ];
  }
  return self;
}

@end
