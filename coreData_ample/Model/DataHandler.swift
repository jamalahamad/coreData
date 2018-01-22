//
//  DataHandler.swift
//  coreData_ample
//
//  Created by Jamal Ahamad on 18/01/18.
//  Copyright © 2018 Jamal Ahamad. All rights reserved.
//

import UIKit
import CoreData

class DataHandler: NSObject {

    var studentArray : [Student] = []
    var editstudent :[Student] = []

   private func getmanagedObjectContext()->NSManagedObjectContext{
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        return context
    }
    
    func saveData (name:String , phone :String ,address : String ,image : Data){
        
        let managedObjectContext = getmanagedObjectContext()
        let entityDesc = NSEntityDescription.entity(forEntityName: "Student", in: managedObjectContext)
        let managedObject = NSManagedObject(entity: entityDesc!, insertInto: managedObjectContext)
        managedObject.setValue(name, forKey: "name")
        managedObject.setValue(phone, forKey: "phone")
        managedObject.setValue(address, forKey: "address")
        managedObject.setValue(image, forKey: "profileImage")
        
        do{
            try managedObjectContext.save()
            print("data saved")
        }catch{
            
            print("data not saved : \(error.localizedDescription)")
        }
    }
    
    func fetchData() -> [Student] {
        
        let context = getmanagedObjectContext()
        
        do{
            studentArray = try context.fetch(Student.fetchRequest())
            
        } catch {
            print("cant fetch :\(error.localizedDescription)")
        }
        
        return studentArray
    }
    
    func deleteData(student :Student) {
        
        let context = getmanagedObjectContext()
        context.delete(student)
        
        do{
            try context.save()
            
        }catch {
            
            print("cant delete : \(error.localizedDescription)")
        }
    }
    
    func editData(name:String , phone :String ,address : String ,image : Data, id : Int) {
        
    let context = getmanagedObjectContext()
        editstudent[id].name = name
        editstudent[id].address = address
        editstudent[id].phone = phone
        editstudent[id].profileImage = image
        
        do {
            try context.save()
            
        } catch  {
            
            print("cant edit \(error.localizedDescription)")
            debugPrint("cant edit ")
        }
    }
    
}
