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
    
    //MARK:- Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
    }
    
    //MARK:- Private functions
    private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)?=nil) {
        let animationOptions: UIView.AnimationOptions = [.allowUserInteraction]
        if isHighlighted {
            UIView.animate(withDuration: 0.2,
                           delay: 0.2,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 7,
                           options: animationOptions, animations: {
                            self.contentView.transform = .init(scaleX: 0.95, y: 0.95)
            }, completion: completion)
        } else {
            UIView.animate(withDuration: 0.2,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                            self.contentView.transform = .identity
            }, completion: completion)
        }
    }
    
}
