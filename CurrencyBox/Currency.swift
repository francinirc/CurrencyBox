//
//  Currency.swift
//  CurrencyBox
//
//  Created by Francini Roberta de Carvalho on 04/01/17.
//  Copyright © 2017 Francini Carvalho. All rights reserved.
//

import Foundation



class Currency {
    
    var name: String?
    var initial: String?
    var countryFlag: String?
    var symbol: String?
    var rate: Double?
    
    
    convenience init() {
        self.init(newName: "", newInitial: "", newCountryFlag: "", newSymbol: "")
    }
    
    init(newName: String, newInitial: String, newCountryFlag: String, newSymbol: String) {
        name = newName
        initial = newInitial
        countryFlag = newCountryFlag
        symbol = newSymbol
    }
    
}

