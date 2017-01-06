//
//  Helpful.swift
//  CurrencyBox
//
//  Created by Francini Roberta de Carvalho on 06/01/17.
//  Copyright © 2017 Francini Carvalho. All rights reserved.
//

import Foundation


class Helpful {
    
    static func getCurrentCurrencySymbol() -> String {
        return Locale.current.currencySymbol!
    }
    
}
