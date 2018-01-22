//
//  MainVC.swift
//  coreData_ample
//
//  Created by Jamal Ahamad on 17/01/18.
//  Copyright © 2018 Jamal Ahamad. All rights reserved.
//

import UIKit
import  CoreData

class MainVC: UIViewController {
    @IBOutlet weak var listTable: UITableView!
    
    var coredataHandler = DataHandler()
    var fetchData : [Student] = []
    var mainontext : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTable.dataSource = self
        listTable.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData = coredataHandler.fetchData()
        listTable.reloadData()
    }
}

// MARK :- Tableview delegate and Datasource

extension MainVC : UITableViewDataSource,UITableViewDelegate{
        
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return fetchData.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! CustomCell
        
        let celldata = fetchData[indexPath.row]
        cell.cellData = celldata
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "cellToEdit", sender: self)
        print("index : \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            let student = fetchData[indexPath.row]
            fetchData.remove(at: indexPath.row)
            coredataHandler.deleteData(student: student)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "cellToEdit" {
            
            let detailVc = segue.destination as! DetailVC
            let index = listTable.indexPathForSelectedRow?.row
            detailVc.toEditData = fetchData[index!]
            detailVc.editArray = fetchData
            detailVc.index = index
        }
    }

}

