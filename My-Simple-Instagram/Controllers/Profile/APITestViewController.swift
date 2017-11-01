//
//  APITestViewController.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 01/11/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import UIKit

class APITestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Actions
    @IBAction func myInfoDidTap(_ sender: Any) {
        API.UserClass.getMyProfile { (success) in
            guard success else {
                print("Errore")
                return
            }
            print("Success")
        }
    }
    @IBAction func otherInfoDidTap(_ sender: Any) {
        API.UserClass.getUserProfile(userId: 10) { (success) in
            guard success else {
                print("Errore")
                return
            }
        }
    }
    @IBAction func myMediaDidTap(_ sender: Any) {
        //TO DO - Not working correctly return only 20 photos
        API.UserClass.getMyMedia(maxId: "", minId: "", count: "40") { (success) in
            guard success else {
                print("Errore")
                return
            }
            print("Success")
        }
    }
    @IBAction func otherMediaDidTap(_ sender: Any) {
    }
    @IBAction func myLikeDidTap(_ sender: Any) {
    }
    @IBAction func searchDidTap(_ sender: Any) {
    }
}
