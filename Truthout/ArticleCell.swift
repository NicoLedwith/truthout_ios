//
//  ArticleCell.swift
//  Truthout
//
//  Created by Nico on 3/28/17.
//  Copyright © 2017 Nico Ledwith. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

   @IBOutlet weak var imgView: UIImageView!
   @IBOutlet weak var titleLbl: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
   func updateUI(article: Article) {
      titleLbl.text = article.title
      let imgURL = article.imgURL
      if imgURL == "" {
         imgView.image = UIImage(named: "to_def_cell_pic")
      } else {
         imgView.downloadedFrom(link: imgURL)
      }
   }
}
