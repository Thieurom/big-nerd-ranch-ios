//
//  ChangeDateViewController.swift
//  Homepwner
//
//  Created by Doan Le Thieu on 3/15/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class ChangeDateViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var item: Item!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Change Date"
        datePicker.date = item.dateCreated
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.dateCreated = datePicker.date
    }
}
