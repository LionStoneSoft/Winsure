//
//  ItemsList.swift
//  Winsure
//
//  Created by Ryan Soanes on 09/07/2019.
//  Copyright © 2019 LionStone. All rights reserved.
//

import UIKit
import CoreData

class ItemsList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var itemTable: UITableView!
    
    var itemObjectsArray = [NSManagedObject]()
    var itemObject: NSManagedObject?
    var locationID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTable.register(UINib(nibName: "ItemXib", bundle: nil), forCellReuseIdentifier: "itemXib")
        itemTable.delegate = self
        itemTable.dataSource = self
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemObject")
        itemObjectsArray.removeAll()
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                if data.value(forKey: "itemID") as? String == locationID {
                    print(data.value(forKey: "itemTitle") as! String)
                    itemObjectsArray = itemObjectsArray + [data]
                }
            }
            itemTable.reloadData()
        } catch {
            print("failed homie")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItemCreate" {
            let secondView = segue.destination as! ItemCreate
            secondView.locationID = locationID
        }
        
        if segue.identifier == "goToItemDetail" {
            let secondView = segue.destination as! ItemView
            secondView.itemObject = itemObject
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemObjectsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemXib", for: indexPath) as! ItemXib
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.itemTitle.text = itemObjectsArray[indexPath.row].value(forKey: "itemTitle") as? String
        cell.itemValue.text = itemObjectsArray[indexPath.row].value(forKey: "itemValue") as? String
        let cellImage = itemObjectsArray[indexPath.row].value(forKey: "itemPicOne")
        if cellImage != nil {
            cell.itemImage.image = UIImage.init(data: cellImage as! Data, scale: 1)
        } else {
            cell.itemImage.image = UIImage.init(named: "scooby")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemObject = itemObjectsArray[indexPath.row]
        self.performSegue(withIdentifier: "goToItemDetail", sender: self)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.itemTable.endUpdates()
    }
    
    
}
