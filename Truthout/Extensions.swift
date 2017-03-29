//
//  Extensions.swift
//  Truthout
//
//  Created by Nico on 3/28/17.
//  Copyright © 2017 Nico Ledwith. All rights reserved.
//

import Foundation
import UIKit

extension String {
   var html2AttributedString: NSAttributedString? {
      guard let data = data(using: .utf8) else { return nil }
      
      do {
         return try NSAttributedString(data: data, options: [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue,
            ], documentAttributes: nil)
      }
      catch let error as NSError {
         print(error.localizedDescription)
         return nil
      }
   }
   var html2String: String {
      return html2AttributedString?.string ?? ""
   }
}

extension UIImageView {
   func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFill) {
      contentMode = mode
      URLSession.shared.dataTask(with: url) { (data, response, error) in
         guard
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
            else { return }
         DispatchQueue.main.async() { () -> Void in
            self.image = image
         }
         }.resume()
   }
   func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFill) {
      guard let url = URL(string: link) else { return }
      downloadedFrom(url: url, contentMode: mode)
   }
}
