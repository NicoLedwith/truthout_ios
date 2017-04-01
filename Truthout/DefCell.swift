//
//  DefCell.swift
//  Truthout
//
//  Created by Nico on 3/28/17.
//  Copyright © 2017 Nico Ledwith. All rights reserved.
//

import UIKit

class DefCell: UIImageView {
   
   override func awakeFromNib() {
      /* rounded corners for image */
      layer.cornerRadius = 15.0
      layer.masksToBounds = true
      
   }
}
