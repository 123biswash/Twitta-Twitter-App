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
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        
        let myPhotoUrl = tweet.user.profilePicUrl
        let profilePhotoUrl = URL(string: myPhotoUrl)
        image.af_setImage(withURL: profilePhotoUrl!)
        tweetText.text = tweet.text
        name.text = tweet.user.name
        favoriteCountLabel.text = "\(tweet.favoriteCount!)"
        retweetCountLabel.text = "\(tweet.retweetCount)"
        
        if tweet.favorited! == true {
            favoriteButton.isSelected = true
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        }
        
        if tweet.retweeted == true {
            retweetButton.isSelected = true
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        }
        
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        if retweetButton.isSelected == true {
            retweetButton.isSelected = false
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            unRetweetTweet()
        }else {
            retweetButton.isSelected = true
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            retweetTweet()
        }
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        if favoriteButton.isSelected == true {
            favoriteButton.isSelected = false
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: .normal)
            unFavoriteTweet()
        }else {
            favoriteButton.isSelected = true
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
            favoriteTweet()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "replySegue" {
            let replyVC = segue.destination as! ComposeViewController
            replyVC.initialtext = "@\(tweet.user.screenName) "
            replyVC.tweetButton.title = "Reply"
        }
        else if segue.identifier == "profileSegue" {
            let profileVC = segue.destination as! ProfileViewController
            profileVC.user = tweet.user
        }
        
    }
    
    func retweetTweet() {
        APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error retweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                self.tweet.retweetCount += 1
                self.tweet.retweeted = true
                self.refreshData()
            }
        }
    }
    
    func unRetweetTweet() {
        APIManager.shared.unRetweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error un-retweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully un-retweeted the following Tweet: \n\(tweet.text)")
                self.tweet.retweetCount -= 1
                self.tweet.retweeted = false
                self.refreshData()
            }
        }
    }
    
    func favoriteTweet() {
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favoriting the following Tweet: \n\(tweet.text)")
                self.tweet.favoriteCount! += 1
                self.tweet.favorited = true
                self.refreshData()
            }
        }
    }
    
    func unFavoriteTweet() {
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error un-favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully un-favoriting the following Tweet: \n\(tweet.text)")
                self.tweet.favoriteCount! -= 1
                self.tweet.favorited = false
                self.refreshData()
            }
        }
    }
    func refreshData() {
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
   
    
}
