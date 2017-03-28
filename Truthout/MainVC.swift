//
//  ViewController.swift
//  Truthout
//
//  Created by Nico on 1/28/17.
//  Copyright © 2017 Nico Ledwith. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash
import Kanna

class MainVC: UIViewController {
   
   @IBOutlet weak var frontImg: ImageViewWithGradient!
   
   var articles = [Article]()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
      
      Alamofire.request("http://www.truth-out.org/feed?format=feed").response {res in
         print(res.data!)
         let xml = SWXMLHash.parse(res.data!)
         var foundImg = false // just search in first article
 
         for a in xml["rss"]["channel"]["item"] {
           
            if let body = HTML(html: (a["description"].element?.text!)!, encoding: .utf8) {
               
               if !foundImg {
                  
                  if let imgLink = body.at_css("img")?["src"]! {
                     print(imgLink)
                     self.frontImg.downloadedFrom(link: imgLink)
                     

                     foundImg = true
                  }
               }
            } else {
               print("couldn't conver to HTML")
            }
            
            
            if let title = a["title"].element?.text {
               if let body = a["description"].element?.text!.html2AttributedString {
                  if let pub = a["pubDate"].element?.text! {
                     self.articles.append(Article(T: title, D: pub, B: body))
                  }
               }
            }
         }
//      print(self.articles)
      }
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }


}

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
