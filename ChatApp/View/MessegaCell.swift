//
//  MessegaCell.swift
//  ChatApp
//
//  Created by Arif Demirkoparan on 11.02.2023.
//

import UIKit

class MessegaCell: UITableViewCell {

    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var avatarIMG: UIImageView!
    @IBOutlet weak var youAvatarIMG: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bubbleView.layer.cornerRadius = bubbleView.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
