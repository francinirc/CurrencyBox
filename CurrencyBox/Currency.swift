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

class CurrencyDAO {
    
    static var filteredCurrencies = [Currency]()
    
    static func getAllCurrencies() -> [Currency] {
        var list = [Currency]()
        
        let c1 = Currency(newName: "Brazilian Real", newInitial: "BRL", newCountryFlag: "br-flag", newSymbol: "R$")
        let c2 = Currency(newName: "US Dollar", newInitial: "USD", newCountryFlag: "usa-flag", newSymbol: "U$")
        let c3 = Currency(newName: "Euro", newInitial: "EUR", newCountryFlag: "ue-flag", newSymbol: "€")
        let c4 = Currency(newName: "British Pound", newInitial: "GBP", newCountryFlag: "uk-flag", newSymbol: "£")
        let c5 = Currency(newName: "Canadian Dollar", newInitial: "CAD", newCountryFlag: "canada-flag", newSymbol: "$")
        let c6 = Currency(newName: "Argentine Peso", newInitial: "ARS", newCountryFlag: "argentina-flag", newSymbol: "$")
        let c7 = Currency(newName: "Japanese Yen", newInitial: "JPY", newCountryFlag: "japan-flag", newSymbol: "¥‎")
        
        list.append(c1)
        list.append(c2)
        list.append(c3)
        list.append(c4)
        list.append(c5)
        list.append(c6)
        list.append(c7)
        
        return list
    }
    
    
    
}
