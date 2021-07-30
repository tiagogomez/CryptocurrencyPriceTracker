//
//  ViewController.swift
//  CryptocurrencyPriceTracker
//
//  Created by Santiago Gómez Giraldo - Ceiba Software on 30/07/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var price: UILabel!
    
    var crypto: [String] = []
    var currency: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        crypto = ["BTC", "ETH", "XRP", "BCH"]
        currency = ["USD", "EUR", "JPY", "CHF"]
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return crypto.count
        default:
            return currency.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return crypto[row]
        default:
            return currency[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let crypto = self.crypto[picker.selectedRow(inComponent: 0)]
        let currency = self.currency[picker.selectedRow(inComponent: 1)]
        print(crypto, currency)
    }
}
