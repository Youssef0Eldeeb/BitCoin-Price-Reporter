//
//  CoinManager.swift
//  BitCoin Price Reporter
//
//  Created by Youssef Eldeeb on 11/10/2021.
//

import Foundation

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "DE768A06-1ACB-4373-9955-9B1802E08E5A"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func gitCoinPrice (for currency : String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString, currency: currency)
    }
    
    func performRequest (with urlString : String, currency : String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                
                if let unwrappedData = data {
                    if let bitcoinPrice = self.parseJSON(unwrappedData){
                        let priceString = String(format: "%.2f", bitcoinPrice)
                        self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                    }
                }
                if let unwrappedError = error {
                    self.delegate?.didFailWithError(error: unwrappedError)
                    return
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            return lastPrice
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
