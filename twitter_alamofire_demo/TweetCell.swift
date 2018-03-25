//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var imageViewLabel: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            let imageURL = URL(string: tweet.user.profilePicUrl)
            tweetTextLabel.text = tweet.text
            imageViewLabel.af_setImage(withURL: imageURL!)
            authorLabel.text = tweet.user.name
            createdAtLabel.text = tweet.createdAtString
            favoriteCountLabel.text = "\(tweet.favoriteCount!)"
            retweetCountLabel.text = "\(tweet.retweetCount)"
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func refreshData(){
        retweetCountLabel.text = "\(tweet.retweetCount)"
        favoriteCountLabel.text = "\(tweet.favoriteCount!)"
    }
    
    
    @IBAction func favorite(_ sender: Any) {
        tweet.favorited = true
        tweet.favoriteCount = tweet.favoriteCount! + 1
        
        favoriteCountLabel.text = "\(tweet.favoriteCount!)"
        
    }
    
    @IBAction func retweet(_ sender: Any) {
        tweet.retweeted = true
        tweet.retweetCount = tweet.retweetCount + 1
        
        retweetCountLabel.text = "\(tweet.retweetCount)"
        
    }
    
}
