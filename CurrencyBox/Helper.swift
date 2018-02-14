//
//  Helpful.swift
//  CurrencyBox
//
//  Created by Francini Roberta de Carvalho on 06/01/17.
//  Copyright © 2017 Francini Carvalho. All rights reserved.
//

import Foundation

/*
 Methods used by any class
 */
class Helper {
    
    static func getCurrentCurrencySymbol() -> String {
        return Locale.current.currencySymbol!
    }
    
    static func getCurrentCurrencyCode() -> String {
        return Locale.current.currencyCode!
    }
}
