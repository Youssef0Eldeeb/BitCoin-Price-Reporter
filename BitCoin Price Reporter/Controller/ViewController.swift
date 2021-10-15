//
//  ViewController.swift
//  BitCoin Price Reporter
//
//  Created by Youssef Eldeeb on 04/10/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var detailsView: UIView!
    
    var coinManger = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsView.layer.cornerRadius = 35
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManger.delegate = self
    }


}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate{
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
    
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.bitCoinLabel.text = price
            self.currencyLabel.text = currency
        }
    }
}

//MARK: - UIPickerView DataSource & Delegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManger.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManger.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManger.currencyArray[row]
        coinManger.gitCoinPrice(for: selectedCurrency)
    }
    
}
