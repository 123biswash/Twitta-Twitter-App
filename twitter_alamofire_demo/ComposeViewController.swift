//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Biswash Adhikari on 3/17/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit


protocol ComposeViewControllerDelegate {
    func did(post: Tweet)
}


class ComposeViewController: UIViewController {
    
    //weak var delegate: ComposeViewControllerDelegate?

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tweetText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapPost(_ sender: Any) {
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
