//
//  FilterSlider.swift
//  PhotoFilter
//
//  Created by Maxym on 4/13/18.
//  Copyright © 2018 Maxym. All rights reserved.
//

import UIKit

class FilterSlider: UIView {

  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var slider: UISlider!
  var delegate: ViewController?
 
  func setupSlider(withMinValue min: Float, andMax max: Float) {
    slider.minimumValue = min
    slider.maximumValue = max
    slider.value = (min + max) / 2
  }
  
  @IBAction func changeSliderValue(_ sender: UISlider) {
    delegate?.changeSliderValue(sender)
  }
  
}
