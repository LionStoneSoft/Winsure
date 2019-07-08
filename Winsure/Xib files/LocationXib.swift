//
//  LocationXib.swift
//  Winsure
//
//  Created by Ryan Soanes on 08/07/2019.
//  Copyright © 2019 LionStone. All rights reserved.
//

import UIKit

class LocationXib: UITableViewCell {

    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var itemsLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var locationImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        roundedImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func roundedImage() {
        self.backgroundImage.layer.cornerRadius = 42
        self.backgroundImage.clipsToBounds = true
        self.locationImage.layer.cornerRadius = 40
        self.locationImage.clipsToBounds = true
    }
    
}
