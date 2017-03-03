//
//  DateExtension.swift
//  CurrencyBox
//
//  Created by Francini Roberta de Carvalho on 05/01/17.
//  Copyright © 2017 Francini Carvalho. All rights reserved.
//

import Foundation


extension Date {
    
    func toStringFullFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy - HH:mm:ss"
        
        return dateFormatter.string(from: self)
    }
    
}
