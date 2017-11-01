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
    
    //MARK:- Variables

    //MARK:- Override
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationUI()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //MARK:- Setup
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
        
        let customView = CustomButtonView(frame: postButton.frame)
        customView.valueLabel.text = "10"
//        customView.set(number: String(myUser.media), description: "post")
//        postButton.addSubview(customView)
        followerButton.addSubview(CustomButtonView(frame: followerButton.frame))
//        followedButton.addSubview(CustomButtonView(frame: followedButton.frame, number: String(myUser.followedBy), description: "seguiti"))
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


