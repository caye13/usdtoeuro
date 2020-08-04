//
//  ViewController.swift
//  conversionofexchange
//
//  Created by Ck2 Jedi on 8/3/20.
//  Copyright © 2020 caye. All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var inputCardView: UIView!
    @IBOutlet weak var usdTextField: ConvertCurrencyTextField!
    @IBOutlet weak var euroAndPoundSterlingSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var outputCardView: UIView!
    @IBOutlet weak var usDollarTitleLabel: UILabel!
    @IBOutlet weak var usDollarLabel: UILabel!
    @IBOutlet weak var convertedAmountTitleLabel: UILabel!
    @IBOutlet weak var convertedAmountLabel: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usdTextField.calculateButtonAction = {
            self.calculate()
       }
    }
    
    
    @IBAction func euroAndPoundSterlingChanged(_ sender: UISegmentedControl) {
        calculate()
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        clear()
    }
    
    func calculate() {
        if self.usdTextField.isFirstResponder {
            self.usdTextField.resignFirstResponder()
        }
        guard let moneyAmountText = self.usdTextField.text,
            let moneyAmount = Double(moneyAmountText) else {
                clear()
                return
        }
        
        let roundedMoneyAmount = (100 * moneyAmount).rounded() / 100
        
        let usdConvertPercent: Double
                switch euroAndPoundSterlingSegmentedControl.selectedSegmentIndex {
                   case 0:
                    usdConvertPercent = 0.85
                    convertedAmountTitleLabel.text = "Euros"
                    convertedAmountLabel.text = "€0.00"
                   case 1:
                       usdConvertPercent = 0.76
                       convertedAmountTitleLabel.text = "Pound Sterlings"
                       convertedAmountLabel.text = "£0.00"
                   default:
                       preconditionFailure("Unexpected index.")
                   }
        
            let usdConvertAmount = roundedMoneyAmount * usdConvertPercent
            let roundedUsdConvertAmount = (100 * usdConvertAmount).rounded() / 100
        
            // Update UI
            self.usdTextField.text = String(format: "%.2f", roundedMoneyAmount)
            self.usDollarLabel.text = String(format: "%.2f", roundedMoneyAmount)
            self.convertedAmountLabel.text = String(format: "%.2f", roundedUsdConvertAmount)

    }
    
    func clear() {
        usdTextField.text = nil
        euroAndPoundSterlingSegmentedControl.selectedSegmentIndex = 0
        usDollarLabel.text = "$0.00"
        convertedAmountLabel.text = "€0.00"
    }


}


