//
//  ViewController.swift
//  LoginWithTwitter
//
//  Created by Hardip Kalola.
//  Copyright © 2017 Hardip Kalola. All rights reserved.
//

import UIKit
import TwitterKit
import TwitterCore

var x: Int?


class ViewController: UIViewController {

    /*************Self Created Var*************/

    var twiData = [String: AnyObject]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginWithTwitter(_ sender: Any) {
        
        Twitter.sharedInstance().logIn(withMethods: [.webBased]) { (session, error) in
            
            if (session != nil) {
                
                print(session as Any)
                print("signed in as \(session!.userName)");
                
                
                let client = TWTRAPIClient.withCurrentUser()
                
                let request = client.urlRequest(withMethod: "GET", url: "https://api.twitter.com/1.1/account/verify_credentials.json", parameters: ["include_entities": "false", "include_email": "true", "skip_status": "true"], error: nil)
                
                client.sendTwitterRequest(request) { response, data, connectionError in
                    
                    print(response as Any)
                    print(data as Any)
                    
                    if connectionError != nil {
                        print("Error: \(connectionError)")
                        
                    }else{
                        do {
                            let twitterJson = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:AnyObject]
                            print("json: \(twitterJson)")
                            let name = twitterJson["name"]
                            print(name as Any)
                            self.twiData.updateValue(twitterJson["name"]!, forKey: "name")
                            self.twiData.updateValue(twitterJson["profile_image_url"]!, forKey: "image")
                            
                            print(self.twiData)
                            
                        } catch let jsonError as NSError {
                            print("json error: \(jsonError.localizedDescription)")
                            
                        }
                    }
                    
                }
                
            } else {
                print("error: \(error!.localizedDescription)");
            }
            
            
        }
        
        
        
    }

    @IBAction func logOut(_ sender: Any) {
        
        
    }

}

