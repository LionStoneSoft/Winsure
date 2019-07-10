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
    let cellImage = ["blueCellGradient", "greenCellGradient", "orangeCellGradient", "purpleCellGradient"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTable.register(UINib(nibName: "LocationXib", bundle: nil), forCellReuseIdentifier: "locationXib")
        locationTable.delegate = self
        locationTable.dataSource = self
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationXib", for: indexPath) as! LocationXib
        cell.backgroundImage.image = UIImage(named: cellImage[indexPath.row % 4])
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "goToItems", sender: self)
    }
    
}

