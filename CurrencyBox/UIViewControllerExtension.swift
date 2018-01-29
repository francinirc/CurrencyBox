//
//  UIViewControllerExtension.swift
//  CurrencyBox
//
//  Created by Francini Roberta de Carvalho on 26/01/18.
//  Copyright © 2018 Francini Carvalho. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,                                                                  action:#selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
