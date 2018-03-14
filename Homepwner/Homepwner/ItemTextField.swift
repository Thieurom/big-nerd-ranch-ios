//
//  ItemTextField.swift
//  Homepwner
//
//  Created by Doan Le Thieu on 3/14/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class ItemTextField: UITextField {
    
    override func becomeFirstResponder() -> Bool {
        layer.borderWidth = 1.0
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor(red: 14.0/255, green: 122.0/255, blue: 255.0/255, alpha: 1.0).cgColor

        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        layer.borderWidth = 0.0
        layer.borderColor = UIColor.clear.cgColor
        
        return super.resignFirstResponder()
    }
}
