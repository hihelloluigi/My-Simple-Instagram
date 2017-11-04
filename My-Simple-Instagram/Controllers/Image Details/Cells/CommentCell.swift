//
//  CommentCell.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 04/11/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var commentNameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    // MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    //MARK:- Helpers
    func set(name: String? = "", comment: String? = "") {
        commentNameLabel.text = name
        commentLabel.text = comment
    }
    private func reset() {
        commentNameLabel.text = nil
        commentLabel.text = nil
    }
}
