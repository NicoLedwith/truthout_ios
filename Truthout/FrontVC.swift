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


class FrontVC: UIViewController {
   
   @IBOutlet weak var frontImg: ImageViewWithGradient!
   @IBOutlet weak var frontHeadline: UILabel!
   
   var AG = ArticleGrab()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      grabTen(AG: AG, frontImg: frontImg, frontHL: frontHeadline)
      
      /* listens for an up swipe */
      let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes))
      upSwipe.direction = .up
      view.addGestureRecognizer(upSwipe)
   }
   
   /* Called when a swipe occurs.
      If the swipe is 'up' it performs the seqgue to the ListVC view
   */
   func handleSwipes(sender: UISwipeGestureRecognizer) {
      if (sender.direction == .up) {
         performSegue(withIdentifier: "ListVC", sender: AG)
      }
   }
   
   /* Just before segue is done, sets the varialbe 'grabbedArticles' on the
      ListVC to the ArticlesGrabbed instance that was loaded in this VC
   */
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
      if let destination = segue.destination as? ListVC {
         
         if let agSend = sender as? ArticleGrab {
            
            destination.grabbedArticles = agSend
         }
      }
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }


}
