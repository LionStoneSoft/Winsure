//
//  LocationCreate.swift
//  Winsure
//
//  Created by Ryan Soanes on 09/07/2019.
//  Copyright © 2019 LionStone. All rights reserved.
//

import UIKit
import TextFieldEffects
import CoreData
import CropViewController

class LocationCreate: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate {
    @IBOutlet var locationCreateTextField: IsaoTextField!
    @IBOutlet var locationCreateBackgroundImage: UIImageView!
    @IBOutlet var addPhotoButtonImage: UIButton!
    
    var imageNSData: NSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        roundedImage()
    }
    
    @IBAction func takePhotoButton(_ sender: UIButton) {
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
        addPhotoButtonImage.setBackgroundImage(image, for: .normal)
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            // handle failed conversion
            print("jpg error")
            return
        }
        imageNSData = imageData as NSData
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func locationCreateButton(_ sender: UIButton) {
        saveData()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func roundedImage() {
        self.addPhotoButtonImage.layer.cornerRadius = 75
        self.addPhotoButtonImage.clipsToBounds = true
        self.locationCreateBackgroundImage.layer.cornerRadius = 50
        self.locationCreateBackgroundImage.clipsToBounds = true
    }
    
    func saveData() {
        //refer to AppDelegate core data container
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        //create context for container
        let managedContext = appDelegate.persistentContainer.viewContext
        //create an entity for new records
        let locationEntity = NSEntityDescription.entity(forEntityName: "LocationObject", in: managedContext)!
        let location = NSManagedObject(entity: locationEntity, insertInto: managedContext)
        location.setValue(locationCreateTextField.text, forKey: "locationName")
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
