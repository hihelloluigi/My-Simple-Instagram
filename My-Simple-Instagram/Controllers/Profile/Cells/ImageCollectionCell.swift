//
//  ImageCollectionCell.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 01/11/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCollectionCell: UICollectionViewCell {
    
    //MARK:- Outlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!

    // MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    // MARK: - Methods
    func set(imageString: String? = "") {
        //TO DO - Indentare meglio / progressview non funziona benissimo
        if let img = imageString, let imageUrl = URL(string: img) {
            imageView.kf.setImage(with: imageUrl, placeholder: nil, options: nil, progressBlock: { (receivedSize, totalSize) in
                let percentage = (Float(receivedSize) / Float(totalSize)) * 100.0
                print("downloading progress: \(percentage)%")
                self.progressView.progress = (Float(receivedSize) / Float(totalSize))
            }, completionHandler: { (image, error, cache, url) in
                if error == nil {
                    self.progressView.isHidden = true
                }
            })
        }
    }
    
    private func reset() {
        imageView.image = nil
        progressView.isHidden = false
    }
}
