//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Nancy Gomez on 3/11/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweetText: UITextView!
    
    var user = User()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillUser()
        loadUser()
    }
    
    func loadUser() {
        APIManager.shared.getCurrentAccount(completion: { (user, error) in
            if error != nil {
                print("error")
            } else if let user = user {
                print("Welcome \(user.name)")
                User.current = user
                self.user = user
                self.fillUser()
            }
        })
        
    }
    
    func fillUser() {
        username.text = user.name
        let url = URL(string: user.profileURL)!
        userImg.af_setImage(withURL: url)
        screenName.text = user.screenName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
