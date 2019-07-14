//
//  ItemCreate.swift
//  Winsure
//
//  Created by Ryan Soanes on 10/07/2019.
//  Copyright © 2019 LionStone. All rights reserved.
//

import UIKit
import CoreData
import TextFieldEffects

class ItemCreate: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet var photoButtonOne: UIButton!
    @IBOutlet var photoButtonTwo: UIButton!
    @IBOutlet var photoButtonThree: UIButton!
    @IBOutlet var photoButtonFour: UIButton!
    @IBOutlet var makeModelTextField: AkiraTextField!
    @IBOutlet var serialNumTextField: AkiraTextField!
    @IBOutlet var purchaseDateTextField: AkiraTextField!
    @IBOutlet var purchaseLocationTextField: AkiraTextField!
    @IBOutlet var valueTextField: AkiraTextField!
    
    var imageNSDataOne: NSData?
    var imageNSDataTwo: NSData?
    var imageNSDataThree: NSData?
    var imageNSDataFour: NSData?
    
    var imageCount = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        purchaseDateTextField.delegate = self
    }
    
    @IBAction func takePhotoButtonOne(_ sender: UIButton) {
        imageCount = 1
        openCamera()
    }
    
    @IBAction func takePhotoButtonTwo(_ sender: UIButton) {
        imageCount = 2
        openCamera()
    }
    
    @IBAction func takePhotoButtonThree(_ sender: UIButton) {
        imageCount = 3
        openCamera()
    }
    
    @IBAction func takePhotoButtonFour(_ sender: UIButton) {
        imageCount = 4
        openCamera()
    }
    
    @IBAction func createItemButton(_ sender: UIBarButtonItem) {
        saveData()
        self.navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        if imageCount == 1 {
            photoButtonOne.setBackgroundImage(image, for: .normal)
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                // handle failed conversion
                print("jpg error")
                return
            }
            imageNSDataOne = imageData as NSData
        } else if imageCount == 2 {
            photoButtonTwo.setBackgroundImage(image, for: .normal)
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                // handle failed conversion
                print("jpg error")
                return
            }
            imageNSDataTwo = imageData as NSData
        } else if imageCount == 3 {
            photoButtonThree.setBackgroundImage(image, for: .normal)
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                // handle failed conversion
                print("jpg error")
                return
            }
            imageNSDataThree = imageData as NSData
        } else if imageCount == 4 {
            photoButtonFour.setBackgroundImage(image, for: .normal)
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                // handle failed conversion
                print("jpg error")
                return
            }
            imageNSDataFour = imageData as NSData
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //Format Date of Birth dd-MM-yyyy
        
        //initially identify your textfield
        
        if textField == purchaseDateTextField {
            
            // check the chars length dd -->2 at the same time calculate the dd-MM --> 5
            if (purchaseDateTextField?.text?.count == 2) || (purchaseDateTextField?.text?.count == 5) {
                //Handle backspace being pressed
                if !(string == "") {
                    // append the text
                    purchaseDateTextField?.text = (purchaseDateTextField?.text)! + "-"
                }
            }
            // check the condition not exceed 9 chars
            return !(textField.text!.count > 9 && (string.count ) > range.length)
        }
        else {
            return true
        }
    }
    
    func openCamera() {
        let camera = UIImagePickerController()
        camera.sourceType = .camera
        camera.delegate = self
        present(camera, animated: true)
    }
    
    func saveData() {
        //refer to AppDelegate core data container
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        //create context for container
        let managedContext = appDelegate.persistentContainer.viewContext
        //create an entity for new records
        let itemEntity = NSEntityDescription.entity(forEntityName: "ItemObject", in: managedContext)!
        let item = NSManagedObject(entity: itemEntity, insertInto: managedContext)
        item.setValue(makeModelTextField.text, forKey: "itemTitle")
        item.setValue(serialNumTextField.text, forKey: "itemSerial")
        item.setValue(purchaseDateTextField.text, forKey: "itemDate")
        item.setValue(purchaseLocationTextField.text, forKey: "itemLocation")
        item.setValue(valueTextField.text, forKey: "itemValue")
        item.setValue(imageNSDataOne, forKey: "itemPicOne")
        item.setValue(imageNSDataTwo, forKey: "itemPicTwo")
        item.setValue(imageNSDataThree, forKey: "itemPicThree")
        item.setValue(imageNSDataFour, forKey: "itemPicFour")
        
//        let uuid = UUID().uuidString
//        item.setValue(uuid, forKey: "locationID")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("could not save. \(error), \(error.userInfo)")
        }
    }
    
}
