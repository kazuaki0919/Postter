//
//  ViewController.swift
//  Postter
//
//  Created by 並木一晃 on 2015/12/31.
//  Copyright © 2015年 並木一晃. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func TweetButton(sender: AnyObject){
            // Twitterの投稿ダイアログを作る
        let cv = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
            // 投稿ダイアログを表示する
        self.present(cv, animated: true, completion:nil )
    }
    
    @IBAction func PhotoButton(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

