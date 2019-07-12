//
//  ItemCreate.swift
//  Winsure
//
//  Created by Ryan Soanes on 10/07/2019.
//  Copyright © 2019 LionStone. All rights reserved.
//

import UIKit

class ItemCreate: UIViewController {
    
    @IBOutlet var photoButtonOne: UIButton!
    @IBOutlet var photoButtonTwo: UIButton!
    @IBOutlet var photoButtonThree: UIButton!
    @IBOutlet var photoButtonFour: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    @IBAction func takePhotoButtonOne(_ sender: UIButton) {
    }
    
    @IBAction func takePhotoButtonTwo(_ sender: UIButton) {
    }
    
    @IBAction func takePhotoButtonThree(_ sender: UIButton) {
    }
    
    @IBAction func takePhotoButtonFour(_ sender: UIButton) {
    }
}
