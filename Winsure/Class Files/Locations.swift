//
//  Locations.swift
//  Winsure
//
//  Created by Ryan Soanes on 07/07/2019.
//  Copyright © 2019 LionStone. All rights reserved.
//

import UIKit

class Locations: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var exportButton: UIBarButtonItem!
    @IBOutlet var locationTable: UITableView!
    @IBOutlet var totalValue: UILabel!
    @IBOutlet var totalItems: UILabel!
    
    let cellColour = [UIColor.red, UIColor.blue, UIColor.green]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTable.register(UINib(nibName: "LocationXib", bundle: nil), forCellReuseIdentifier: "locationXib")
        locationTable.delegate = self
        locationTable.dataSource = self
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationXib", for: indexPath) as! LocationXib
            cell.backgroundImage.backgroundColor = cellColour[indexPath.row % 3]
        return cell
    }

}

