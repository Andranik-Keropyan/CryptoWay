//
//  ExchangesModel.swift
//  Crypto Way
//
//  Created by mac on 24.11.23.
//

import Foundation

class ExchangesModel {
    var nameOfExchange: String
    var address: String
    var phoneOfExchange: String
    var Longitude: Double
    var Latitude: Double

    
    init(nameOfExchange: String, address: String,phoneOfExchange: String, Longitude: Double, Latitude: Double) {
        self.nameOfExchange = nameOfExchange
        self.address = address
        self.phoneOfExchange = phoneOfExchange
        self.Longitude = Longitude
        self.Latitude = Latitude
    }
}
