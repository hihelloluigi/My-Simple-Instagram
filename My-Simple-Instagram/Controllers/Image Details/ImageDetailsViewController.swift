//
//  ImageDetailsViewController.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 01/11/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import UIKit
import Agrume

class ImageDetailsViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var fullScreenButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var arButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Variables
    var imageId: String = ""
    var image: UIImage!
    var comments = [Comment]()

    //MARK:- Override
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationUI()
        setupTableView()
        downloadComments()
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
        
        locationLabel.isHidden = image.locationName.isEmpty
        if !image.locationName.isEmpty {
            locationLabel.text = image.locationName
        }
    }
    private func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
    }
    
    //MARK:- Helpers
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    //MARK:- API
    private func downloadComments() {
        API.CommentClass.getCommentsWith(mediaId: imageId) { (success) in
            guard success else {
                print("Call error")
                return
            }
            
            self.comments = Comment.getAllComments(withImageID: self.imageId)
            self.tableView.reloadData()
        }
    }
    
    //MARK:- Actions
    @IBAction func fullScreenDidTap(_ sender: Any) {
        let agrume = Agrume(image: self.image, backgroundColor: .black)
        agrume.hideStatusBar = true
        agrume.showFrom(self)
    }
    @IBAction func shareDidTap(_ sender: Any) {
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        present(vc, animated: true)
    }
    @IBAction func arDidTap(_ sender: Any) {
        if #available(iOS 11.0, *) {
            let mainStoryboard = UIStoryboard(name: "AR", bundle: Bundle.main)
            let controller: ARViewController = mainStoryboard.instantiateViewController(withIdentifier: "ARViewController") as! ARViewController
            controller.image = image
            self.present(controller, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Versione non supportata", message: "La tua versione di iOS non supporta la realtà aumentata, se vuoi utilizzare questa funziona aggiorna il tuo sistema operativo", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            alert.present(self, animated: true, completion: nil)
        }
    }
}

//MARK:- TableView Data Source
extension ImageDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comment cell", for: indexPath) as! CommentCell
        
        let comment = comments[indexPath.row]
        cell.set(name: comment.username, comment: comment.commentText)
        
        return cell
    }
}

