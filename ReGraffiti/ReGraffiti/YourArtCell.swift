//
//  YourArtCell.swift
//  ReGraffiti
//
//  Created by Matt Bond on 12/12/16.
//  Copyright © 2016 Matt Bond. All rights reserved.
//

import UIKit

class YourArtCell: UITableViewCell {
    @IBOutlet weak var cellArt: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
