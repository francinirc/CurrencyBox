//
//  CurrencyDAO.swift
//  CurrencyBox
//
//  Created by Francini Roberta de Carvalho on 26/07/17.
//  Copyright © 2017 Francini Carvalho. All rights reserved.
//

import Foundation


class CurrencyDAO {
    
    static var filteredCurrencies = [Currency]()
    
    static func getAllCurrencies() -> [Currency] {
        var list = [Currency]()
        
        let c1 = Currency(newName: "Brazilian Real", newCode: "BRL", newCountryFlag: "br-flag", newSymbol: "R$")
        let c2 = Currency(newName: "US Dollar", newCode: "USD", newCountryFlag: "usa-flag", newSymbol: "U$")
        let c3 = Currency(newName: "Euro", newCode: "EUR", newCountryFlag: "ue-flag", newSymbol: "€")
        let c4 = Currency(newName: "British Pound", newCode: "GBP", newCountryFlag: "uk-flag", newSymbol: "£")
        let c5 = Currency(newName: "Canadian Dollar", newCode: "CAD", newCountryFlag: "canada-flag", newSymbol: "$")
        //let c6 = Currency(newName: "Argentine Peso", newInitial: "ARS", newCountryFlag: "argentina-flag", newSymbol: "$")
        let c7 = Currency(newName: "Japanese Yen", newCode: "JPY", newCountryFlag: "japan-flag", newSymbol: "¥‎")
        
        list.append(c1)
        list.append(c2)
        list.append(c3)
        list.append(c4)
        list.append(c5)
        //list.append(c6)
        list.append(c7)
        
        return list
    }
    
    
    
}
