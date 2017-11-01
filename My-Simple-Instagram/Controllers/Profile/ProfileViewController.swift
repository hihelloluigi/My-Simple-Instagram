//
//  ProfileViewController.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 30/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import UIKit
import Kingfisher
import Cards

class ProfileViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- Variables
    var images = [Image]()
    var card: CardHighlight!
    @IBOutlet weak var second: CardHighlight!

    //MARK:- Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        myProfileButton()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK:- Setup
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func myProfileButton() {
        
        let profileButton: LAButton = LAButton(type: .custom)
        profileButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
//        profileButton.isCircle = true
        profileButton.layer.masksToBounds = true

        profileButton.backgroundColor = .red
        let barButtonItem = UIBarButtonItem(customView: profileButton)
        self.navigationItem.setRightBarButton(barButtonItem, animated: true)
        
        
        var stringUrl = ""
        if let myProfile = User.getMyProfile() {
            stringUrl = myProfile.profilePicture
        }
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 34, height: 34))
        imageView.layer.masksToBounds = true
        imageView.kf.setImage(with: URL(string: stringUrl), placeholder: #imageLiteral(resourceName: "ic_account")) { (image, error, cache, url) in
            if let img = image, error == nil {
                let newImage = self.resizeImage(image: img, targetSize: CGSize(width: 34, height: 34))
                profileButton.setImage(newImage, for: .normal)
                let barButtonItem = UIBarButtonItem(customView: profileButton)
                self.navigationItem.setRightBarButton(barButtonItem, animated: true)
            }
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    //MARK:- Actions
    @IBAction func myInfoDidTap(_ sender: Any) {
        API.UserClass.getMyProfile { (success) in
            guard success else {
                print("Errore")
                return
            }
            print("Ok zio")
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
            guard let id = Config.id() else {
                print("No id set")
                return
            }
            self.images = Image.getAllImages(withUserID: id)
            self.collectionView.reloadData()
            print("Io ho: \(self.images.count) immagini")
            
        }
    }
    @IBAction func otherMediaDidTap(_ sender: Any) {
    }
    @IBAction func myLikeDidTap(_ sender: Any) {
    }
    @IBAction func searchDidTap(_ sender: Any) {
    }
}

//MARK:- Collection view data source
extension ProfileViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
}

//MARK:- Collection view delegate
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "card cell", for: indexPath) as! CardCollectionCell

        let image = self.images[indexPath.row]
        cell.set(imageString: image.standardResolution, index: indexPath.row, viewController: self)
        return cell
    }
}

extension ProfileViewController: CardDelegate {
    func cardDidTapInside(card: Card) {
        let mainStoryboard = UIStoryboard(name: "Profile", bundle: Bundle.main)
        let cardContentVC: ImageDetailsViewController = mainStoryboard.instantiateViewController(withIdentifier: "ImageDetailsViewController") as! ImageDetailsViewController
        cardContentVC.imageId = self.images[card.tag].imageId
        cardContentVC.image = card.backgroundImage
        
        card.shouldPresentVC(cardContentVC, from: self)

//        card.shouldPresent(cardContentVC.view, from: self)
    }
    
    func cardHighlightDidTapButton(card: CardHighlight, button: UIButton) {
        card.buttonText = "HEY!"
    }
}
