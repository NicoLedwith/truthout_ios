//
//  gradientImage.swift
//  Truthout
//
//  Created by Nico on 1/28/17.
//  Copyright © 2017 Nico Ledwith. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class ImageViewWithGradient: UIImageView {
   
   let gradientLayer: CAGradientLayer
   
   override init(frame: CGRect) {
      gradientLayer = CAGradientLayer()
      super.init(frame: frame)
      self.setup()
   }
   
   required init(coder aDecoder: NSCoder) {
      gradientLayer = CAGradientLayer()
      super.init(coder: aDecoder)!
      self.setup()
   }
   
   func setup() {
      let colors: [CGColor] = [
         UIColor.clear.cgColor,
         UIColor.black.cgColor
      ]
      gradientLayer.colors = colors
      gradientLayer.isOpaque = false
      self.layer.addSublayer(gradientLayer)
   }
   
   override func layoutSubviews() {
      gradientLayer.frame = self.layer.bounds
   }
}
