//
//  GalleryViewController.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 01/11/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import UIKit
import Kingfisher
import Cards

class GalleryViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- Variables
    var images = [Image]()
    var card: CardHighlight!
    
    //MARK:- Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCollectionView()
        myProfileButton()
        downloadRecentMedia()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    //MARK:- Setup
    private func setup() {
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .automatic
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        }
    }
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func myProfileButton() {
        //TO DO - Add profile button like apple store
        let profileButton: LAButton = LAButton(type: .custom)
        profileButton.frame = CGRect(x: 0, y: 100, width: 34, height: 34)
        profileButton.isCircle = true
        profileButton.layer.masksToBounds = true
        profileButton.widthAnchor.constraint(equalToConstant: 34.0).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 34.0).isActive = true
        profileButton.addTarget(self, action: #selector(openMyProfile), for: .touchUpInside)
        var stringUrl = ""
        if let myProfile = User.getMyProfile() {
            stringUrl = myProfile.profilePicture
        }
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 34, height: 34))
        imageView.layer.masksToBounds = true
        imageView.kf.setImage(with: URL(string: stringUrl), placeholder: #imageLiteral(resourceName: "ic_account")) { (image, error, cache, url) in
            if let img = image, error == nil {
                profileButton.setImage(img, for: .normal)
                let barButtonItem = UIBarButtonItem(customView: profileButton)
                self.navigationItem.setRightBarButton(barButtonItem, animated: true)
            }
        }
    }
    
    @objc private func openMyProfile() {
        let mainStoryboard = UIStoryboard(name: "Profile", bundle: Bundle.main)
        let controller: ProfileViewController = mainStoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK:- Helpers
    private func downloadRecentMedia(maxId: String = "", minId: String = "", count: String = "") {
        API.UserClass.getMyMedia(maxId: maxId, minId: minId, count: count) { (success) in
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
        }
    }
}

//MARK:- Collection view data source
extension GalleryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
}

//MARK:- Collection view delegate
extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "card cell", for: indexPath) as! CardCollectionCell
        
        let image = self.images[indexPath.row]
        cell.set(imageString: image.standardResolution, index: indexPath.row, viewController: self)
        return cell
    }
}

extension GalleryViewController: CardDelegate {
    func cardDidTapInside(card: Card) {
        let mainStoryboard = UIStoryboard(name: "Profile", bundle: Bundle.main)
        let cardContentVC: ImageDetailsViewController = mainStoryboard.instantiateViewController(withIdentifier: "ImageDetailsViewController") as! ImageDetailsViewController
        cardContentVC.imageId = self.images[card.tag].imageId
        cardContentVC.image = card.backgroundImage
        
        card.shouldPresent(cardContentVC.view, from: self)
    }
    
    func cardHighlightDidTapButton(card: CardHighlight, button: UIButton) {
        card.buttonText = "HEY!"
    }
}
