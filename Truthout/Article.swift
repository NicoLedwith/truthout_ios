//
//  Article.swift
//  Truthout
//
//  Created by Nico on 3/28/17.
//  Copyright © 2017 Nico Ledwith. All rights reserved.
//

import Foundation

class Article: CustomStringConvertible {
   let dateFormatter = DateFormatter()
   
   private var title: String
   private var date_published: String
   private var body: NSAttributedString
   //others 
   
   init(T: String, D: String, B: NSAttributedString) {
      title = T
      date_published = D
      body = B
   }
   
   var description: String {
      return "\n\(title): \(date_published)\n"
   }
}
