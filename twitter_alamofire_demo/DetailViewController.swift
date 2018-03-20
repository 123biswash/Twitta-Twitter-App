//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Biswash Adhikari on 3/17/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            let imageURL = URL(string: tweet.user.profilePicUrl!)
            tweetText.text = tweet.text
            image.af_setImage(withURL: imageURL!)
            name.text = tweet.user.name
            
            favoriteCountLabel.text = "\(tweet.favoriteCount!)"
            retweetCountLabel.text = "\(tweet.retweetCount)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func refreshData(){
        retweetCountLabel.text = "\(tweet.retweetCount)"
        favoriteCountLabel.text = "\(tweet.favoriteCount!)"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onReply(_ sender: Any) {
        
    }
    @IBAction func onRetweet(_ sender: Any) {
        tweet.retweeted = true
        tweet.retweetCount = tweet.retweetCount + 1
        retweetCountLabel.text = "\(tweet.retweetCount)"
    }
    @IBAction func onFavorite(_ sender: Any) {
        tweet.favorited = true
        tweet.favoriteCount = tweet.favoriteCount! + 1
        favoriteCountLabel.text = "\(tweet.favoriteCount!)"
    }
    
    
}
