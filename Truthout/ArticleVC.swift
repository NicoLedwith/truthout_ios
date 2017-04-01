//
//  ArticleVC.swift
//  Truthout
//
//  Created by Nico on 3/28/17.
//  Copyright © 2017 Nico Ledwith. All rights reserved.
//

import UIKit

class ArticleVC: UIViewController {

   @IBOutlet weak var imgView: UIImageView!
   @IBOutlet weak var bodyText: UILabel!
   @IBOutlet weak var titleLbl: UILabel!
   @IBOutlet weak var pubDate: UILabel!
   
   @IBOutlet weak var mainView: UIView!
   
   @IBAction func backPressed(_ sender: Any) {
      dismiss(animated: true, completion: nil)
   }
   
   private var _article: Article!
   
   var article: Article {
      get {
         return _article
      } set {
         _article = newValue
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
      populateArticle(article: _article)
    }

   func populateArticle(article: Article) {
      print(article.body)
      
      if (article.hasIamge) {
         imgView.image = article.image
      } else {
        imgView.removeFromSuperview()
      }
      bodyText.attributedText = article.body
      pubDate.text = article.datePublished
      titleLbl.text = article.title
   }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
