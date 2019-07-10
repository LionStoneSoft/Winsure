//
//  ItemXib.swift
//  Winsure
//
//  Created by Ryan Soanes on 10/07/2019.
//  Copyright © 2019 LionStone. All rights reserved.
//

import UIKit

class ItemXib: UITableViewCell {

    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemTitle: UILabel!
    @IBOutlet var itemValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func roundedImage() {
        self.backgroundImage.layer.cornerRadius = 38
        self.backgroundImage.clipsToBounds = true
        self.itemImage.layer.cornerRadius = 32
        self.itemImage.clipsToBounds = true
    }
    
}
