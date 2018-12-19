//
//  NewsLeadCellTableViewCell.swift
//  SlideOutAnimation
//
//  Created by TRINGAPPS on 25/11/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//

import UIKit

class NewsLeadCellTableViewCell: UITableViewCell {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leadImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
