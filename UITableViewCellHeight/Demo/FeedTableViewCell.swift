//
//  FeedTableViewCell.swift
//  UITableViewCellHeight
//
//  Created by SnoHo on 2017/6/27.
//  Copyright © 2017年 SnoHo. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var userNamelabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var entity:FeedEntity? {
        didSet{
            guard let entity = entity else { return }
            titleLabel.text = entity.title
            contentLabel.text = entity.content
            userNamelabel.text = entity.username
            titleLabel.text = entity.time
            contentImageView.image = UIImage(named: entity.imageName ?? "")
        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
