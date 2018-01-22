//
//  CustomCell.swift
//  coreData_ample
//
//  Created by Jamal Ahamad on 18/01/18.
//  Copyright © 2018 Jamal Ahamad. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var profimage: UIImageView!
    @IBOutlet weak var nameLabl: UILabel!
    @IBOutlet weak var phoneLble: UILabel!
    
    var cellData : Student? {
        
        didSet{
            updateUi()
        }
    }
    
    func updateUi(){
        
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        backView.layer.shadowOpacity = 1
        backView.layer.shadowRadius = 5
        let imageData = UIImage(data: (cellData?.profileImage)!)
        profimage.image = imageData
        nameLabl.text = cellData?.name
        phoneLble.text = cellData?.phone
    }
}
