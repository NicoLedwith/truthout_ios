//: Playground - noun: a place where people can play

import UIKit
import SWXMLHash
import Alamofire
import Fuzi
import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true
URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)

class Article: CustomStringConvertible {
   let dateFormatter = DateFormatter()
   
   private var title: String
   private var date_published: String
   //others
   
   init(T: String, D: String) {
      title = T
      date_published = D
   }
   
   var description: String {
      return "\n\(title): \(date_published)\n"
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
   func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
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
   func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
      guard let url = URL(string: link) else { return }
      downloadedFrom(url: url, contentMode: mode)
   }
}

var articles = [Article]()


//Alamofire.request("http://www.truth-out.org/feed?format=feed").response {res in
//   print(res.data!)
//   let xml = SWXMLHash.parse(res.data!)
//   var foundImg = false
//   
//   for a in xml["rss"]["channel"]["item"] {

//      if let body = HTML(html: (a["description"].element?.text!)!, encoding: .utf8) {
//         print(body.css("img"))
//         if !foundImg {
//            
//            if let imgLink = body.at_css("img")?.text! {
//               print(imgLink)
//               self.frontImg.downloadedFrom(link: imgLink)
//               foundImg = true
//            }
//         }
//      } else {
//         print("couldn't conver to HTML")
//      }
      
      
//      if let title = a["title"].element?.text {
//         if let body = a["description"].element?.text!.html2AttributedString {
//            if let pub = a["pubDate"].element?.text! {
//               self.articles.append(Article(T: title, D: pub, B: body))
//            }
//         }
//      }
//   }
//   print(self.articles)
//}
