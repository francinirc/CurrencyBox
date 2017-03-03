//
//  StringExtension.swift
//  CurrencyBox
//
//  Created by Francini Roberta de Carvalho on 03/03/17.
//  Copyright © 2017 Francini Carvalho. All rights reserved.
//

import Foundation


extension String {

    func toShortDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        
        return dateFormatter.date(from: self)!
    }
    
}
