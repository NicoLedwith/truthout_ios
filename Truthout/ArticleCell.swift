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
      if (article.hasIamge) {
         imgView.image = article.image
      }
      else {
         imgView.image = UIImage(named: "to_def_cell_pic")
      }
      titleLbl.text = article.title
   }
}
