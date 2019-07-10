//
//  ItemsList.swift
//  Winsure
//
//  Created by Ryan Soanes on 09/07/2019.
//  Copyright © 2019 LionStone. All rights reserved.
//

import UIKit

class ItemsList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var itemTable: UITableView!
    @IBOutlet var addItemButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTable.register(UINib(nibName: "ItemXib", bundle: nil), forCellReuseIdentifier: "itemXib")
        itemTable.delegate = self
        itemTable.dataSource = self
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemXib", for: indexPath) as! ItemXib
        return cell
    }
}
