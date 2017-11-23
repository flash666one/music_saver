//
//  EmptyTableViewCell.swift
//  VKplayer
//
//  Created by Артём Горюнов on 31.10.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {

    @IBOutlet weak var SongName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
