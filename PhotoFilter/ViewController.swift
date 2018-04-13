//
//  ViewController.swift
//  PhotoFilter
//
//  Created by Maxym on 3/14/18.
//  Copyright © 2018 Maxym. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var buttons: [UIButton]!
  @IBOutlet var backView: UIScrollView!
  
  // MARK: - Properties
  let allFilters = [Filter.sepia, Filter.exposure, Filter.vignette, Filter.colorControls]
  var openGLContext = EAGLContext(api: .openGLES3)
  var context: CIContext?
  var tempImage: UIImage?
  var allSlidersLists = [Int : SlidersList]()
  var selectedFilter: Filter?
  var selectedFilterIndex = 0
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    if let openContext = openGLContext {
      context = CIContext(eaglContext: openContext)
    }
    for i in 0 ..< buttons.count {
      buttons[i].setTitle(allFilters[i].filterName, for: .normal)
    }
    tempImage = imageView.image
  }
  
  @IBAction func clickButton(_ sender: UIButton) {
    if let index = buttons.index(of: sender) {
      let filter = allFilters[index]
      selectedFilter = filter
      selectedFilterIndex = index
      backView.subviews.forEach { $0.removeFromSuperview() }
      if allSlidersLists[index] == nil {
        let view = SlidersList(frame: CGRect(origin: CGPoint.zero, size: backView.frame.size))
        view.delegate = self
        view.createSliders(attributes: selectedFilter?.attributes, attributeValues: selectedFilter?.attributeValues)
        view.frame.size.height = view.height
        allSlidersLists[index] = view
        backView.addSubview(view)
        backView.contentSize.height = view.height
      } else {
        if let listView = allSlidersLists[index] {
          backView.addSubview(listView)
          backView.contentSize.height = listView.height
        }
      }
    }
    tempImage = imageView.image
  }
  
  func changeSliderValue(_ sender: UISlider) {
    changeFilterValues()
  }
  
  func changeFilterValues() {
    guard let startImage = tempImage else { return }
    let image = CIImage(image: startImage)
    guard let filter = selectedFilter else { return }
    filter.setInputImage(image: image)
    var i = 0
    for attribute in filter.attributes {
      filter.setAttributeValue(allSlidersLists[selectedFilterIndex]?.slidersValues[i], forKey: attribute)
      i += 1
    }
    if let output = filter.outputImage {
      guard let cgImgResult = context?.createCGImage(output, from: output.extent) else { return }
      let filteredImage = UIImage(cgImage: cgImgResult)
      DispatchQueue.main.async {
        self.imageView.image = filteredImage
      }
    }
  }
}

