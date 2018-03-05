//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favCount: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBAction func retweet(_ sender: Any) {
        if(tweet.retweeted == false)
        {
            tweet.retweeted = true
            tweet.retweetCount += 1
            retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for:[])
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
            self.refreshData()
        }
        else
        {
            tweet.retweeted = false
            tweet.retweetCount -= 1
            retweetButton.setImage(UIImage(named: "retweet-icon.png"), for:[])
            APIManager.shared.unRetweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unRetweeted the following Tweet: \n\(tweet.text)")
                }
            }
            self.refreshData()
        }
    }
    
    @IBAction func tapFavorite(_ sender: Any) {
        if(tweet.favorited == false){
            tweet.favorited = true
            tweet.favoriteCount! += 1
            favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for:[])
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
                
            }
            self.refreshData()
        }
        else
        {
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            favoriteButton.setImage(UIImage(named: "favor-icon.png"), for:[])
            APIManager.shared.unFavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unFavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unFavorited the following Tweet: \n\(tweet.text)")
                }
            }
            self.refreshData()
        }
    }
    var tweet: Tweet! {
        didSet {
            refreshData()
        }
    }
    
    func refreshData() {
//        check favorited
        if(tweet.favorited == true) {
            favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for:[])
        } else {
            favoriteButton.setImage(UIImage(named: "favor-icon.png"), for:[])
        }
//        check retweeted
        if(tweet.retweeted == true) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for:[])
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon.png"), for:[])
        }
        let url = URL(string: tweet.user.profileURL)!
        profileImg.af_setImage(withURL: url)
        tweetTextLabel.text = tweet.text
        username.text = tweet.user.name
        screenName.text = ("@" + tweet.user.screenName!) as String?
        date.text = tweet.createdAtString
        retweetCount.text = String(tweet.retweetCount)
        favCount.text = String(describing: tweet.favoriteCount)
        if(tweet.favoriteCount != nil) {
            let count = tweet.favoriteCount!
            favCount.text = String(count)
        } else {
            favCount.text = "0"
        }
        
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2;
        profileImg.layer.borderWidth = 1
        profileImg.layer.borderColor = UIColor.black.cgColor
        profileImg.clipsToBounds = true
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
