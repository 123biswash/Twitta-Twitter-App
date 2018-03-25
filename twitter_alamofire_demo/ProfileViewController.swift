//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Biswash Adhikari on 3/20/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tweetsTableView: UITableView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var coverPic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var tweets: [Tweet] = []
    
    var user: User = User.current! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 250
        
        profilePic.layer.cornerRadius = 10
        
        let myPhotoUrl = User.current?.profilePicUrl
        let profilePhotoUrl = URL(string: myPhotoUrl!)
        profilePic.af_setImage(withURL: profilePhotoUrl!)
        
        userName.text = "@\(user.screenName)"
        name.text = user.name
        followersCountLabel.text = "\(user.followersCount)"
        followingCountLabel.text = "\(user.followingCount)"
        tweetCountLabel.text = "\(user.tweetCount)"
        // Do any additional setup after loading the view.
        
        //print(user.backgroundImageUrl)
        if user.backgroundImageUrl != nil {
            coverPic.af_setImage(withURL: user.backgroundImageUrl)
        }
        retrieveTimelineTweets()
    }
    
    func retrieveTimelineTweets() {
        //print(user.name)
        APIManager.shared.getUserTimeline(with: user.screenName, options: [:]) { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tweetsTableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
