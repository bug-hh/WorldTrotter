//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by bughh on 2019/6/28.
//  Copyright © 2019 bughh. All rights reserved.
//

import UIKit

class ConversionViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var celsiusLabel: UILabel!
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        print(dateFormatter.string(from: now))
        
        if let hours = Int(dateFormatter.string(from: now)), hours >= 18 {
            view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelsiusLabel()
        textField.delegate = self
        print("ConversionViewController loaded its view")
    }
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fv = fahrenheitValue {
            return fv.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ sender: UITextField) {
        if let text = sender.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    func updateCelsiusLabel() {
        if let cv = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value:cv.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    // delegate: An object that acts on behalf of, or in coordination with, another object.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let letterSet = NSCharacterSet.letters
        if string.rangeOfCharacter(from: letterSet) != nil {
            return false
        }
        
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        
        let existingTextRange = textField.text?.range(of: decimalSeparator)
        let replacementTextRange = string.range(of: decimalSeparator)
        if existingTextRange != nil, replacementTextRange != nil {
            return false
        } else {
            return true
        }
    }
}

