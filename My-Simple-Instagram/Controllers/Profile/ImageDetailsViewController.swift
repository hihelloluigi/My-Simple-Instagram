//
//  ImageDetailsViewController.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 01/11/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import UIKit

class ImageDetailsViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var arButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    //MARK:- Variables
    var imageId: String = ""
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurationUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Setup
    private func configurationUI() {
        guard let image = Image.getImage(withId: imageId) else {
            print("Not found")
            return
        }
        
        likesLabel.text = "\(image.likesNumber) likes"
        commentsLabel.text = "\(image.commentsNumber) comments"
    }
    
    //MARK:- Actions
    @IBAction func likeDidTap(_ sender: Any) {
        print("so")
    }
    
    @IBAction func shareDidTap(_ sender: Any) {
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        present(vc, animated: true)
    }
    @IBAction func saveDidTap(_ sender: Any) {
    }
    @IBAction func arDidTap(_ sender: Any) {
    }
}
