//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Nancy Gomez on 3/10/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweet: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favCount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
