//
//  ItemsXib.swift
//  Winsure
//
//  Created by Ryan Soanes on 09/07/2019.
//  Copyright © 2019 LionStone. All rights reserved.
//

import UIKit

class ItemsXib: UITableViewCell {
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemName: UILabel!
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
        self.backgroundImage.layer.cornerRadius = 35
        self.backgroundImage.clipsToBounds = true
    }
    
}
