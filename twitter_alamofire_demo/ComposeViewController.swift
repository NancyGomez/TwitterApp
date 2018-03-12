//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Nancy Gomez on 3/11/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var charCount: UILabel!
    @IBOutlet weak var postButton: UIButton!
    
    var user = User()
    var delegate: ComposeViewControllerDelegate?
    
    override func viewDidLoad() {
        tweetText.delegate = self
        super.viewDidLoad()
        postButton.isUserInteractionEnabled = false
        postButton.setTitleColor(UIColor.gray, for: .normal)
        fillUser()
        loadUser()
    }
    func textViewDidChange(_ textView: UITextView) {
        if(textView.text != ""){
            postButton.isUserInteractionEnabled = true
            postButton.setTitleColor(UIColor.blue, for: .normal)
            
        }
        else{
            postButton.isUserInteractionEnabled = false
            postButton.setTitleColor(UIColor.gray, for: .normal)
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        charCount.text = "\(characterLimit - newText.count)"
        // The new text should be allowed? True/False
        return newText.count < characterLimit
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
    @IBAction func didPost(_ sender: Any) {
        APIManager.shared.composeTweet(with: tweetText.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                
                let main = UIStoryboard(name: "Main", bundle: nil)
                let vc = main.instantiateViewController(withIdentifier: "TimelineViewController") as UIViewController
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    

}

protocol ComposeViewControllerDelegate {
   
    func did(post: Tweet)
}
