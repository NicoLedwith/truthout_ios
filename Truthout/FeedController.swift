//
//  FeedController.swift
//  Truthout
//
//  Created by Nico on 3/28/17.
//  Copyright © 2017 Nico Ledwith. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SWXMLHash
import Kanna

let url = "http://www.truth-out.org/feed?format=feed"

func grabTen(AG: ArticleGrab, frontImg: ImageViewWithGradient, frontHL: UILabel) {
   
   Alamofire.request(url).response { res in
      let xml = SWXMLHash.parse(res.data!)
      var first = true
      
      for a in xml["rss"]["channel"]["item"] {
         let title = a["title"].element?.text! ?? "truth-out.org"
         let body = a["description"].element?.text! ?? ""
         let pub = a["pubDate"].element?.text! ?? ""
         
         if first {
            /* first article must populate the opening screen
             * other articles just go in the array
             */
            setFirst(title: title, body: body, frontImg: frontImg, frontHL: frontHL)
            first = false
         }
         
         /* All articles go in array */
         AG.addArticle(a: Article(T: title, D: pub, B: body))
      }
   }
}

func setFirst(title: String, body: String, frontImg: ImageViewWithGradient, frontHL: UILabel) {
   // update title
   
   //update image
   if let h_body = HTML(html: body, encoding: .utf8) {
      if let imgLink = h_body.at_css("img")?["src"]! {
         frontImg.downloadedFrom(link: imgLink)
      }
   }
   else {
      print("convert to HTML failed")
   }
   frontHL.text = title
}
















