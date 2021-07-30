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
    
    var crypto: [String] = ["BTC", "ETH", "XRP", "BCH"]
    var currency: [String] = ["USD", "EUR", "JPY", "CHF"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        guard let firstCrypto = crypto.first,
              let firstCurrency = currency.first else { return }
        getPrice(crypto: firstCrypto, currency: firstCurrency)
    }
    
    private func getPrice(crypto: String, currency: String) {
        guard let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=\(crypto)&tsyms=\(currency)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("API Call Failure")
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Double] else {
                print("Parsing Failure")
                return
            }
            guard let price = json[currency] else {
                print("No Data Available")
                return
            }
            let formatter = NumberFormatter()
            formatter.currencyCode = currency
            formatter.numberStyle = .currency
            let formattedPrice = formatter.string(from: NSNumber(value: price))
            DispatchQueue.main.async {
                self.price.text = formattedPrice
            }
        }.resume()
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
        getPrice(crypto: crypto, currency: currency)
    }
}
