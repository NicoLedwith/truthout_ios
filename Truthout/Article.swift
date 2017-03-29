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
   //others 
   
   init(T: String, D: String, B: String) {
      _title = T
      _date_published = D
      _body = B
   }
   
   var title: String {
      return _title
   }
   
   var datePublished:String {
      return _date_published
   }
   
   var body: NSAttributedString {
      return _body.html2AttributedString!
   }
   
   var bodyString: String {
      return _body
   }
   
   var imgURL: String {
      if let h_body = HTML(html: _body, encoding: .utf8) {
         if let imgLink = h_body.css("img").first?["src"]! {
            return imgLink
         }
      }
      return ""
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
