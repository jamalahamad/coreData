//
//  DetailVC.swift
//  coreData_ample
//
//  Created by Jamal Ahamad on 17/01/18.
//  Copyright © 2018 Jamal Ahamad. All rights reserved.
//

import UIKit
import CoreData

class DetailVC: UIViewController {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var addressTextFld: UITextField!
    @IBOutlet weak var phoneTextFld: UITextField!
    @IBOutlet weak var nameTexFld: UITextField!
    let coreDataHandler = DataHandler()
    var detailContext : NSManagedObject!
    var toEditData:Student?
    var index : Int?
    var editArray :[Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let student = toEditData{
            nameTexFld.text = student.name
            addressTextFld.text = student.address
            phoneTextFld.text = student.phone
            let imageData = UIImage(data: student.profileImage!)
            profileImg.image = imageData
        }
    }

    @IBAction func saveButton(_ sender: Any) {
            
    if addressTextFld.text == "" || phoneTextFld.text == "" ||
            nameTexFld.text == "" {
            
            return
            
             }else {
            
               let name = nameTexFld.text
               let address = addressTextFld.text
               let phone = phoneTextFld.text
               let image = UIImage(named: "profImage")
               let imageData = UIImagePNGRepresentation(image!)
                coreDataHandler.saveData(name: name!, phone: phone!, address: address!, image: imageData!)
                nameTexFld.text = ""
                addressTextFld.text = ""
                phoneTextFld.text = ""
           }
        self.navigationController?.popViewController(animated: true)
        }
       
    @IBAction func editButton(_ sender: Any) {
        
        let imageData = UIImagePNGRepresentation(profileImg.image!)
        let appdel = UIApplication.shared.delegate as! AppDelegate
        let context = appdel.persistentContainer.viewContext
        
        editArray[index!].name = nameTexFld.text
        editArray[index!].address = addressTextFld.text
        editArray[index!].phone = phoneTextFld.text
        editArray[index!].profileImage = imageData
        do {
            try context.save()
            
        } catch  {
            
            print("cant edit \(error.localizedDescription)")
            debugPrint("cant edit ")
        }
    self.navigationController?.popViewController(animated: true)
    }
}

