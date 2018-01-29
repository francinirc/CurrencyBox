//
//  ConvertedValuesCell.swift
//  CurrencyBox
//
//  Created by Francini Roberta de Carvalho on 8/20/16.
//  Copyright © 2016 Francini Carvalho. All rights reserved.
//

import UIKit

class ConvertedValuesCell: UITableViewCell {


    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var convertedValueLabel: UILabel!
    @IBOutlet weak var defaultValueConvertedLabel: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
