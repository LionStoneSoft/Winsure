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
        itemTable.register(UINib(nibName: "ItemsXib", bundle: nil), forCellReuseIdentifier: "itemsXib")
        itemTable.delegate = self
        itemTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsXib", for: indexPath) as! ItemsXib
        return cell
    }
}
