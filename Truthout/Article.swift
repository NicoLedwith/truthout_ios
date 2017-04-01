//
//  Article.swift
//  Truthout
//
//  Created by Nico on 3/28/17.
//  Copyright © 2017 Nico Ledwith. All rights reserved.
//

import Foundation
import Kanna

class Article: CustomStringConvertible {
   let dateFormatter = DateFormatter()
   
   private var _title: String
   private var _date_published: String
   private var _body: String
   private var _image: UIImage
   private var _has_image: Bool
   
   init(Title: String, Date: String, Body: String, Image: UIImage, HasImage: Bool) {
      _title = Title
      _date_published = Date
      _body = Body
      _image = Image
      _has_image = HasImage
   }
   
   var title: String {
      return _title
   }
   
   var datePublished: String {
      
      let DF = DateFormatter()
      DF.dateFormat = "EE, dd MMM yyyy HH:mm:ss ZZZZ"
      let pubDate = DF.date(from: _date_published)
      
      return (pubDate?.description)!
      
   }
   
   var body: NSAttributedString {
      return _body.html2AttributedString!
   }
   
   var bodyString: String {
      return _body
   }
   
   var image: UIImage {
      return _image
   }
   
   var hasIamge: Bool {
      get {
         return _has_image
      }
      set {
         _has_image = newValue
      }
   }
   
   var description: String {
      return "\n\(_title): \(_date_published)\n"
   }
}

class ArticleGrab {
   private var _articles: [Article]
   private var _lastUpdated: Date
   
   init() {
      _articles = [Article]()
      _lastUpdated = Date(timeIntervalSinceNow: 0)
   }
   
   var articles: [Article] {
      return _articles
   }
   
   var lastUpdated: Date {
      return _lastUpdated
   }
   
   func addArticle(a: Article) {
      _articles.append(a)
   }
   
   func getArticle(index: Int) -> Article {
      return _articles[index]
   }
   
}
