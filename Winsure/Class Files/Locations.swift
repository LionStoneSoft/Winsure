//
//  Locations.swift
//  Winsure
//
//  Created by Ryan Soanes on 07/07/2019.
//  Copyright © 2019 LionStone. All rights reserved.
//

import UIKit
import CoreData
import PopupDialog

class Locations: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, LocationReloadDataDelegate {

    @IBOutlet var exportButton: UIBarButtonItem!
    @IBOutlet var locationTable: UITableView!
    @IBOutlet var totalValue: UILabel!
    @IBOutlet var totalItems: UILabel!
    
    let cellColour = [UIColor.red, UIColor.blue, UIColor.green]
    let cellImage = ["blueCellGradient", "greenCellGradient", "orangeCellGradient", "purpleCellGradient"]
    var locationObjectsArray = [NSManagedObject]()
    var locationID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTable.register(UINib(nibName: "LocationXib", bundle: nil), forCellReuseIdentifier: "locationXib")
        locationTable.delegate = self
        locationTable.dataSource = self
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationObject")
        locationObjectsArray.removeAll()
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "locationName") as! String)
                locationObjectsArray = locationObjectsArray + [data]
            }
            locationTable.reloadData()
        } catch {
            print("failed homie")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {
            let secondView = segue.destination as! ItemsList
            secondView.locationID = locationID
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationObjectsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationXib", for: indexPath) as! LocationXib
        cell.backgroundImage.image = UIImage(named: cellImage[indexPath.row % 4])
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.titleLabel.text = locationObjectsArray[indexPath.row].value(forKey: "locationName") as? String
        let imagetest = locationObjectsArray[indexPath.row].value(forKey: "locationPicture")
        if imagetest != nil {
            cell.locationImage.image = UIImage.init(data: imagetest as! Data, scale: 1)
        } else {
            cell.locationImage.image = UIImage.init(named: "scooby")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationID = locationObjectsArray[indexPath.row].value(forKey: "locationID") as? String
        self.performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.locationTable.endUpdates()
    }
    
    @IBAction func addLocationButton(_ sender: UIButton) {
        showCustomDialog()
        viewWillAppear(false)
    }
    
    func showCustomDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let addLocationVC = LocationAddPopup(nibName: "LocationAddPopup", bundle: nil)
        
        // Create the dialog
        let popup = PopupDialog(viewController: addLocationVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceUp,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        addLocationVC.delegate = self
////        // Create first button
//        let buttonOne = CancelButton(title: "Cancel", height: 60) {
//            print("user cancelled")
//        }
//
//        // Create second button
//        let buttonTwo = DefaultButton(title: "Create", height: 60) {
//            print("user created")
//        }
//
////        // Add buttons to dialog
//        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        present(popup, animated: animated, completion: nil)
    }
    
    func reloadTableData() {
        viewWillAppear(true)
    }
}

