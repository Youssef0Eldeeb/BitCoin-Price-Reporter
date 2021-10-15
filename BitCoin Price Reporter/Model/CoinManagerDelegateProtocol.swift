//
//  CoinManagerDelegateProtocol.swift
//  BitCoin Price Reporter
//
//  Created by Youssef Eldeeb on 13/10/2021.
//

import Foundation

protocol CoinManagerDelegate {
    
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}
