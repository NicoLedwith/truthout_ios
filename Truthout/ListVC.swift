//
//  ListVC.swift
//  Truthout
//
//  Created by Nico on 3/28/17.
//  Copyright © 2017 Nico Ledwith. All rights reserved.
//

import UIKit

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

   @IBOutlet weak var tableView: UITableView!
   
   var avc = ArticleVC()
   private var _grabbedArticles: ArticleGrab!
   
   var grabbedArticles: ArticleGrab {
      get {
         return _grabbedArticles
      } set {
         _grabbedArticles = newValue
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      tableView.delegate = self
      tableView.dataSource = self
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell {
         
         let article = _grabbedArticles.getArticle(index: indexPath.row)
         cell.updateUI(article: article)
         return cell
      }
      else {
         return UITableViewCell()
      }
      
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return _grabbedArticles.articles.count
   }
   
   // segue
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ArticleVC" {
         if let destination = segue.destination as? ArticleVC {
            let index = tableView.indexPathForSelectedRow?.row
            destination.article = _grabbedArticles.getArticle(index: index!)
         }
      }
   }
}
