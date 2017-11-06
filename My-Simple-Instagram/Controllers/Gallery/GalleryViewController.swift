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
    @IBOutlet weak var refreshImageButton: UIBarButtonItem!
    
    //MARK:- Variables
    var images = [Image]()
    var card: CardHighlight!
    var refresher: UIRefreshControl!

    //MARK:- Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCollectionView()
        configurationUI()
        downloadProfile()
        downloadRecentMedia()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK:- Setup
    private func setup() {
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .automatic
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        }
    }
    private func setupImages() {
        guard let id = Config.id() else {
            print("Errore")
            return
        }
        self.images = Image.getAllImages(withUserID: id)
        self.collectionView.reloadData()
    }
    private func configurationUI() {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.refresher = UIRefreshControl()
        self.collectionView.alwaysBounceVertical = true
        self.refresher.addTarget(self, action: #selector(RefreshDidTap(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            setRefresherWith(text: "Common" ~> "pull to refresh", andColor: .white)
            self.collectionView.refreshControl = refresher
        } else {
            setRefresherWith(text: "Common" ~> "pull to refresh", andColor: .black)
            self.collectionView.addSubview(refresher)
        }
    }
    private func myProfileButton() {
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
                self.navigationItem.setLeftBarButton(barButtonItem, animated: true)
            }
        }
    }
    private func setRefresherWith(text: String = "", andColor c: UIColor) {
        self.refresher.tintColor = c
        self.refresher.attributedTitle = NSAttributedString(string: text, attributes: [NSAttributedStringKey.foregroundColor : c])
    }
    
    //MARK:- Helpers
    @objc private func openMyProfile() {
        let mainStoryboard = UIStoryboard(name: "Profile", bundle: Bundle.main)
        let controller: ProfileViewController = mainStoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK:- APIs
    private func downloadProfile() {
        API.UserClass.getMyProfile { (success) in
            guard success else {
                Message.show(error: "Gallery" ~> "download profile error")
                return
            }
            //Add my profile bar button
            self.myProfileButton()
        }
    }
    @objc func downloadRecentMedia(_ maxId: String = "", _ minId: String = "", _ count: String = "") {
        //ADD activity indicator
        API.UserClass.getMyMedia(maxId: maxId, minId: minId, count: count) { (success) in
            self.refresher.endRefreshing()
            guard success else {
                Message.show(error: "Gallery" ~> "downloadMediaError")
                return
            }
            self.setupImages()
        }
    }
    
    //MARK:- Actions
    @IBAction func RefreshDidTap(_ sender: Any) {
        downloadRecentMedia()
        if let _ = sender as? UIBarButtonItem, self.images.count > 0 {
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
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
        cell.set(imageString: image.standardResolution, locationString: image.locationName, index: indexPath.row, viewController: self)
        return cell
    }
}

extension GalleryViewController: CardDelegate {
    func cardDidTapInside(card: Card) {
        let mainStoryboard = UIStoryboard(name: "Gallery", bundle: Bundle.main)
        let cardContentVC: ImageDetailsViewController = mainStoryboard.instantiateViewController(withIdentifier: "ImageDetailsViewController") as! ImageDetailsViewController
        cardContentVC.imageId = self.images[card.tag].imageId
        cardContentVC.image = card.backgroundImage
        
        card.shouldPresent(cardContentVC, from: self)
    }
    func cardHighlightDidTapButton(card: CardHighlight, button: UIButton) {
    }
}
