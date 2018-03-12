//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Nancy Gomez on 3/10/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweet: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favCount: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!

    var tweetInfo = Tweet()
//    var tweetInfo: Tweet! {
//        didSet {
//            tweetInfo = Tweet()
//            refreshData()
//        }
//    }
    
    func refreshData() {
        //        check favorited
        if(tweetInfo.favorited == true) {
            favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for:[])
        } else {
            favoriteButton.setImage(UIImage(named: "favor-icon.png"), for:[])
        }
        //        check retweeted
        if(tweetInfo.retweeted == true) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for:[])
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon.png"), for:[])
        }
        username.text = tweetInfo.user.name
        let url = URL(string: tweetInfo.user.profileURL)!
        userImg.af_setImage(withURL: url)
        screenName.text = tweetInfo.user.screenName
        tweet.text = tweetInfo.text
        createdAt.text = tweetInfo.createdAtString
        retweetCount.text = String(describing: tweetInfo.retweetCount) + " Retweets"
        if(tweetInfo.favoriteCount != nil) {
            let count = tweetInfo.favoriteCount!
            favCount.text = String(count) + " Retweets"
        } else {
            favCount.text = "0 Retweets"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()
        
    }
    @IBAction func onRetweet(_ sender: Any) {
        if(tweetInfo.retweeted == false)
        {
            tweetInfo.retweeted = true
            tweetInfo.retweetCount += 1
            retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for:[])
            APIManager.shared.retweet(tweetInfo) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
            self.refreshData()
        } else {
            tweetInfo.retweeted = false
            tweetInfo.retweetCount -= 1
            retweetButton.setImage(UIImage(named: "retweet-icon.png"), for:[])
            APIManager.shared.unRetweet(tweetInfo) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unRetweeted the following Tweet: \n\(tweet.text)")
                }
            }
            self.refreshData()
        }
    }
    @IBAction func onFavorite(_ sender: Any) {
        if(tweetInfo.favorited == false){
            tweetInfo.favorited = true
            tweetInfo.favoriteCount! += 1
            favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for:[])
            APIManager.shared.favorite(tweetInfo) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
                
            }
            self.refreshData()
        } else {
            tweetInfo.favorited = false
            tweetInfo.favoriteCount! -= 1
            favoriteButton.setImage(UIImage(named: "favor-icon.png"), for:[])
            APIManager.shared.unFavorite(tweetInfo) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unFavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unFavorited the following Tweet: \n\(tweet.text)")
                }
            }
            self.refreshData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Tweet"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
