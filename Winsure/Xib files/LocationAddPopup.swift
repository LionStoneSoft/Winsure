//
//  LocationAddPopup.swift
//  Winsure
//
//  Created by Ryan Soanes on 13/07/2019.
//  Copyright © 2019 LionStone. All rights reserved.
//

import UIKit
import TextFieldEffects
import CropViewController
import CoreData

protocol LocationReloadDataDelegate: class {
    func reloadTableData()
}

class LocationAddPopup: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var addPhotoButton: UIButton!
    @IBOutlet var locationAddTextField: AkiraTextField!
    
    var imageNSData: NSData?
    var delegate: LocationReloadDataDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationAddTextField.delegate = self
        roundedImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func endEditing() {
        view.endEditing(true)
    }
    
    func roundedImage() {
        let radius: CGFloat = addPhotoButton.bounds.size.width / 2.0
        self.addPhotoButton.layer.cornerRadius = radius
        self.addPhotoButton.clipsToBounds = true
    }

    @IBAction func addLocationPhotoButton(_ sender: UIButton) {
        let camera = UIImagePickerController()
        camera.sourceType = .camera
        //camera.allowsEditing = true
        camera.delegate = self
        present(camera, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        let cropViewController = CropViewController(image: image)
        cropViewController.delegate = self
        present(cropViewController, animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        // 'image' is the newly cropped version of the original image
        addPhotoButton.setBackgroundImage(image, for: .normal)
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            // handle failed conversion
            print("jpg error")
            return
        }
        imageNSData = imageData as NSData
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createLocationButton(_ sender: UIButton) {
        saveData()
        self.delegate?.reloadTableData()
        dismiss(animated: true, completion: nil)
    }
    
    func saveData() {
        //refer to AppDelegate core data container
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        //create context for container
        let managedContext = appDelegate.persistentContainer.viewContext
        //create an entity for new records
        let locationEntity = NSEntityDescription.entity(forEntityName: "LocationObject", in: managedContext)!
        let location = NSManagedObject(entity: locationEntity, insertInto: managedContext)
        location.setValue(locationAddTextField.text, forKey: "locationName")
        location.setValue(imageNSData, forKey: "locationPicture")
        let uuid = UUID().uuidString
        location.setValue(uuid, forKey: "locationID")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("could not save. \(error), \(error.userInfo)")
        }
    }
    
}

extension LocationAddPopup: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing()
        return true
    }
}
