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
    
    var tweetInfo = Tweet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = tweetInfo.user.name
        let url = URL(string: tweetInfo.user.profileURL)!
        userImg.af_setImage(withURL: url)
        screenName.text = tweetInfo.user.screenName
        tweet.text = tweetInfo.text
        createdAt.text = tweetInfo.createdAtString
        retweetCount.text = String(describing: tweetInfo.retweetCount)
        if(tweetInfo.favoriteCount != nil) {
            let count = tweetInfo.favoriteCount!
            favCount.text = String(count)
        } else {
            favCount.text = "0"
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
