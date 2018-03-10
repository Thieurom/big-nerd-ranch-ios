//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Doan Le Thieu on 3/6/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController{
    
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateCelsiusLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let currentHour = Calendar.current.component(.hour, from: Date())
        if currentHour < 7 || currentHour > 19 {
            view.backgroundColor = UIColor(red: 128/255.0, green: 73/255.0, blue: 57/255.0, alpha: 1.0)
        } else {
            view.backgroundColor = UIColor(red: 245/255.0, green: 244/255.0, blue: 241/255.0, alpha: 1.0)
        }
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }

    
    @IBAction func fahrenheitFieldEditingChanged(_ sender: UITextField) {
        if let text = sender.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
}


extension ConversionViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let decimalDigits = CharacterSet.decimalDigits
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        
        for scalar in string.unicodeScalars {
            if !decimalDigits.contains(scalar) && String(scalar) != decimalSeparator {
                return false
            }
        }
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        }
        
        return true
    }
}
