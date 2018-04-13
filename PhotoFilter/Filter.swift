//
//  Filter.swift
//  PhotoFilter
//
//  Created by Maxym on 4/12/18.
//  Copyright © 2018 Maxym. All rights reserved.
//

import UIKit

enum Filters: String {
  case CISepiaTone
  case CIExposureAdjust
  case CIVignette
  case CIColorControls
  
  var title: String {
    switch self {
    case .CISepiaTone:
      return "Sepia"
    case .CIExposureAdjust:
      return "Exposure"
    case .CIVignette:
      return "Vignette"
    case .CIColorControls:
      return "Color Controls"
    }
  }
  
  var attributes: [String] {
    switch self {
    case .CISepiaTone:
      return [kCIInputIntensityKey]
    case .CIExposureAdjust:
      return [kCIInputEVKey]
    case .CIVignette:
      return [kCIInputIntensityKey, kCIInputRadiusKey]
    case .CIColorControls:
      return [kCIInputSaturationKey, kCIInputBrightnessKey, kCIInputContrastKey]
    }
  }
  
  var attributeValues: [(Float, Float)] {
    switch self {
    case .CISepiaTone:
      return [(0.0, 2.0)]
    case .CIExposureAdjust:
      return [(0.0, 1.0)]
    case .CIVignette:
      return [(-1.0, 1.0), (0.0, 2.0)]
    case .CIColorControls:
      return [(0.0, 2.0), (-1.0, 1.0), (0.0, 2.0)]
    }
  }
}

struct Filter {

  let filter: CIFilter?
  let attributes: [String]
  let attributeValues: [(Float, Float)]
  
  let filterName: String
  
  var outputImage: CIImage? {
    return filter?.outputImage
  }
  
  func setInputImage( image: CIImage?) {
    self.filter?.setValue(image, forKey: kCIInputImageKey)
  }
  
  func setAttributeValue(_ value: Any?, forKey key: String) {
    self.filter?.setValue(value, forKey: key)
  }
  
  static var sepia: Filter {
    return Filter(filter: CIFilter(name: Filters.CISepiaTone.rawValue), attributes: Filters.CISepiaTone.attributes, attributeValues: Filters.CISepiaTone.attributeValues, filterName: Filters.CISepiaTone.title)
  }
  
  static var exposure: Filter {
    return Filter(filter: CIFilter(name: Filters.CIExposureAdjust.rawValue), attributes: Filters.CIExposureAdjust.attributes, attributeValues: Filters.CIExposureAdjust.attributeValues, filterName: Filters.CIExposureAdjust.title)
  }
  
  static var vignette: Filter {
    return Filter(filter: CIFilter(name: Filters.CIVignette.rawValue), attributes: Filters.CIVignette.attributes, attributeValues: Filters.CIVignette.attributeValues, filterName: Filters.CIVignette.title)
  }
  
  static var colorControls: Filter {
    return Filter(filter: CIFilter(name: Filters.CIColorControls.rawValue), attributes: Filters.CIColorControls.attributes, attributeValues: Filters.CIColorControls.attributeValues, filterName: Filters.CIColorControls.title)
  }
  
}
