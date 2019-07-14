//
//  ItemView.swift
//  Winsure
//
//  Created by Ryan Soanes on 10/07/2019.
//  Copyright © 2019 LionStone. All rights reserved.
//

import UIKit
import CoreData

class ItemView: UIViewController {
    
    var itemObject: NSManagedObject?
    @IBOutlet var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        testLabel.text = itemObject?.value(forKey: "itemTitle") as! String
    }
}
