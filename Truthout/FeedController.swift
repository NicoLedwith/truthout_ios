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
         let body_raw_text = a["description"].element?.text!
         
         var body = HTML(html: body_raw_text!, encoding: .utf8)
         
         // remove first <div> which is always the intro text, don't need this
         body?.body?.removeChild((body?.at_css("div"))!)
         body = changeImgWidths(d: body!)
         
         let (img, hasImage) = grabFirstImage(html: body!)
         
         body = removeFirstImage(body: body!)
         
         let bodyString = body?.at_css("div")?.innerHTML! ?? ""
         let pub = a["pubDate"].element?.text! ?? ""
         
         if first {
            /* first article must populate the opening screen
             * other articles just go in the array
             */
            setFirst(title: title, img: img, frontImg: frontImg, frontHL: frontHL)
            first = false
         }
         
         /* All articles go in array */
         AG.addArticle(a: Article(Title: title, Date: pub, Body: bodyString, Image: img, HasImage: hasImage))
      }
   }
}

func grabBodyFullText(b: HTMLDocument) -> HTMLDocument {
   b.body?.removeChild(b.at_css("div")!)
   return b
}

func removeFirstImage(body: HTMLDocument) -> HTMLDocument {
   if (body.at_css("div")?.at_css("img")) != nil {
      print("found first image node")
      body.at_css("div")?.removeChild(body.at_css("p")!)
   }
   
   print(body.innerHTML!)
   return body
}

func changeImgWidths(d: HTMLDocument) -> HTMLDocument {
   let screenWidth = UIScreen.main.bounds.width
   
   for var img in d.css("img") {
      img["width"] = "\(screenWidth)"
   }
   
   return d
}

func grabFirstImage(html: HTMLDocument) -> (UIImage, Bool) {
   var img = UIImage(named: "to_def_bg")
   var has = false
   
   if let imgNode = html.at_css("img") {
      if let imgLink = imgNode["src"] {
         do {
            let data = try Data(contentsOf: URL(string: imgLink)!)
            img = UIImage(data: data)!
            has = true
         }
         catch {
            print("img DL failed")
         }
      }
   }
   return (img!, has)
}

func setFirst(title: String, img: UIImage, frontImg: ImageViewWithGradient, frontHL: UILabel) {
   //update title
   //update image
   
   frontImg.image = img
   frontHL.text = title
}
















