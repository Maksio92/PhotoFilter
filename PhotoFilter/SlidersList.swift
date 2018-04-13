//
//  SlidersList.swift
//  PhotoFilter
//
//  Created by Maxym on 4/13/18.
//  Copyright © 2018 Maxym. All rights reserved.
//

import UIKit

class SlidersList: UIView {

  let sliderViewHeight: CGFloat = 70.0
  var sliders = [FilterSlider]()
  var delegate: ViewController?
  
  var height: CGFloat {
    return CGFloat(sliders.count) * sliderViewHeight
  }
  
  var slidersValues: [Float] {
    var allValues = [Float]()
    for filterSlider in sliders {
      let value = filterSlider.slider.value
      allValues.append(value)
    }
    return allValues
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func createSliders( attributes: [String]?, attributeValues: [(Float, Float)]?) {
    guard let filterAttributes = attributes, let filterValues = attributeValues else { return }
    for i in 0 ..< (filterAttributes.count) {
      guard let filterSlider = Bundle.main.loadNibNamed("FilterSlider", owner: self, options: nil)?.last as? FilterSlider else { return }
      
      filterSlider.titleLabel.text = filterAttributes[i]
      filterSlider.setupSlider(withMinValue: filterValues[i].0, andMax: filterValues[i].1)
      self.addSubview(filterSlider)
      filterSlider.translatesAutoresizingMaskIntoConstraints = false
      filterSlider.topAnchor.constraint(equalTo: self.topAnchor, constant: (sliderViewHeight * CGFloat(i))).isActive = true
      filterSlider.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
      filterSlider.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
      filterSlider.heightAnchor.constraint(equalToConstant: sliderViewHeight).isActive = true
      filterSlider.delegate = delegate
      sliders.append(filterSlider)
    }
  }
}
