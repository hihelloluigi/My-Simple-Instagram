//
//  ProfileViewController.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 30/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var webSiteButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var followerButton: UIButton!
    @IBOutlet weak var followedButton: UIButton!
    @IBOutlet weak var bgImage: UIImageView!
    
    //MARK:- Variables
    var timer: Timer = Timer()
    
    //MARK:- Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configurationUI()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }

    //MARK:- Setup
    private func setup() {
        guard let myUser = User.getMyProfile() else {
            print("Profile not found")
            return
        }
        setBackgroundImage(user: myUser)
    }
    private func configurationUI() {
        guard let myUser = User.getMyProfile() else {
            print("Profile not found")
            return
        }
        usernameLabel.text = myUser.username
        descriptionLabel.text = myUser.bio
        webSiteButton.setTitle(myUser.website, for: .normal)
        profileImageView.isCircle()
        profileImageView.kf.setImage(with: URL(string: myUser.profilePicture), placeholder: #imageLiteral(resourceName: "ic_account"))
        postButton.setTitle(String(myUser.media), for: .normal)
        followerButton.setTitle(String(myUser.followedBy), for: .normal)
        followedButton.setTitle(String(myUser.follows), for: .normal)
    
        timer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(callTimer(timer:)), userInfo: myUser, repeats: true)
    }
    //MARK:- Helpers
    @objc private func callTimer(timer: Timer) {
        guard let userInfo = timer.userInfo as? User else {
            return
        }
        setBackgroundImage(user: userInfo)
    }
    private func setBackgroundImage(user: User) {
        let images = Image.getAllImages(withUserID: user.userID)
        let number = arc4random_uniform(UInt32(images.count))
        bgImage.kf.setImage(with: URL(string: images[Int(number)].standardResolution))
    }

    //MARK:- Actions
    @IBAction func webSiteDidTap(_ sender: Any) {
        Utility.link(url: webSiteButton.titleLabel?.text)
    }
    @IBAction func postDidTap(_ sender: Any) {
    }
    @IBAction func followerDidTap(_ sender: Any) {
        print("test")
    }
    @IBAction func followedDidTap(_ sender: Any) {
    }
}


