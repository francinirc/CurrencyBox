//
//  ValueConversionViewController.swift
//  CurrencyBox
//
//  Created by Francini Roberta de Carvalho on 8/18/16.
//  Copyright © 2016 Francini Carvalho. All rights reserved.
//

import UIKit

class ValueConversionViewController: UIViewController {

    // ViewController constants
    let cellIdentifier = "convertedValues"
    
    
    // Outlets
    @IBOutlet weak var convertedValuesTableView: UITableView!
    @IBOutlet weak var valueToConvert: UITextField!
    @IBOutlet weak var sourceCurrencyButton: UIButton!
    
    
    // Properties
    var bookmarkedCurrencies = [Currency]()
    var sourceCurrency = Currency(newName: "US Dollar", newCode: "USD", newCountryFlag: "", newSymbol: "U$")
    var valuesConverted = [Double]()
    
    
    // MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        convertedValuesTableView.dataSource = self
        hideKeyboard()
        setSourceCurrencyButton(currency: sourceCurrency)
        
        print(Helper.getCurrentCurrencySymbol())
        print(Helper.getCurrentCurrencyCode())
    }

    override func viewWillAppear(_ animated: Bool) {
        bookmarkedCurrencies = CurrencyDAO.filteredCurrencies 
        checkForConversion()
    }
   

    // MARK: Unwind Segues
    @IBAction func cancelToValueConversionViewController(_ segue:UIStoryboardSegue) {
    }
    
    
    // MARK: Actions
    
    @IBAction func convertCurrencies(_ sender: AnyObject) {
        checkForConversion()
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "selectCurrencySegue" {
            
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! CurrencySearchController
            
            targetController.delegate = self            
        }
    }
    
    // MARK: - Class methods
    
    func checkForConversion() {
        
        let noValue = valueToConvert.text!.isEmpty
        let noCurrencies = bookmarkedCurrencies.count == 0
        
        
        if noValue && noCurrencies {
            showAlert(message: "Informe um valor e as moedas que deseja converter")
        } else if noValue {
            showAlert(message: "Informe um valor que deseja converter")
        } else if noCurrencies {
            showAlert(message: "Informe as moedas que deseja converter")
            
        } else {
            getRates()
        }
        
//        var message = ""
        
//        if valueToConvert.text!.isEmpty {
//            //showAlert(message: "Informe um valor para converter.")
//            message = "Informe um valor para converter."
//        } else if bookmarkedCurrencies.count == 0 {
//            //showAlert(message: "Marque as moedas desejadas.")
//            message = "Marque as moedas desejadas."
//        }
//        if message.isEmpty {
//            getRates()
//        } else {
//            showAlert(message: message)
//        }
        
        
        
    }
    
    func getRates() {
        FixerioAPIService.getLatestRates(fromCurrency: sourceCurrency.code!, toCurrencies: bookmarkedCurrencies) { (conversion, error) in
            if let conversion = conversion {
                //self.values = conversion.currencies!
                
                DispatchQueue.main.async {
                    self.convertValues(conversion: conversion)
                    self.convertedValuesTableView.reloadData()
                    print("atualizou")
                }
            }
        }
    }
    
    func convertValues(conversion: Conversion) {
        if !valueToConvert.text!.isEmpty {
            valuesConverted = [Double]()
            let baseValue = stringToDouble(with: valueToConvert.text!)
            
            for i in 0...conversion.currencies!.count - 1 {
                let value = conversion.currencies![i].rate! * baseValue
                valuesConverted.append(value)
            }
            
            print("values = ", valuesConverted.count)
        } else {
            
        }
    }
    
    func stringToDouble(with value: String) -> Double {
        let string = value.replacingOccurrences(of: ",", with: ".")
        if let doubleValue = Double(string) {
            return doubleValue
        } else {
            return Double()
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setSourceCurrencyButton(currency: Currency) {
        let currencyTitle = "\(currency.symbol!) - \(currency.code!)(\(currency.name!))"
        sourceCurrencyButton.setTitle(currencyTitle, for: UIControlState.normal)
        print("----", currencyTitle)
    }
    
}


extension ValueConversionViewController: UITableViewDataSource {
    
    // MARK: TableView Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bookmarkedCurrencies.count > 0 {
            tableView.backgroundView = UIView()
            
            return self.bookmarkedCurrencies.count
        } else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "Nenhuma moeda selecionada :("
            noDataLabel.textColor = UIColor.darkGray
            noDataLabel.textAlignment = .center
            
            tableView.backgroundView = noDataLabel
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! ConvertedValuesCell
        
        cell.flagImageView.layer.borderWidth = 1
        cell.flagImageView.layer.masksToBounds = false
        cell.flagImageView.layer.borderColor = UIColor.lightGray.cgColor
        cell.flagImageView.layer.cornerRadius = cell.flagImageView.frame.height / 2
        cell.flagImageView.clipsToBounds = true
        
        cell.flagImageView.image = UIImage(named: self.bookmarkedCurrencies[indexPath.row].countryFlag!)
        cell.initialsLabel.text = self.bookmarkedCurrencies[indexPath.row].code
        cell.currencyNameLabel.text = self.bookmarkedCurrencies[indexPath.row].name
        print("Total currencies bookmarked = ", bookmarkedCurrencies.count)
        print("Total values converted = ", valuesConverted.count)
        
        if bookmarkedCurrencies.count > 0 && valuesConverted.count > 0 {
            let formattedValue = String(format: "%.4f",valuesConverted[indexPath.row])
            cell.convertedValueLabel.text = "\(self.bookmarkedCurrencies[indexPath.row].symbol!) \(formattedValue)"
            cell.defaultValueConvertedLabel.text = "1,00 \(sourceCurrency.code!) = \(bookmarkedCurrencies[indexPath.row].code!) \(bookmarkedCurrencies[indexPath.row].rate!)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if bookmarkedCurrencies.count > 0 {
            return "Última atualização em: \(Date.init().toStringFullFormat())"
        } else {
            return ""
        }
    }
    
}


extension ValueConversionViewController: CurrencySearchControllerDelegate {
    
    func getSelectedCurrency(currency: Currency) {
        sourceCurrency = currency

        setSourceCurrencyButton(currency: currency)
        
//        let currencyTitle = "\(currency.symbol!) - \(currency.code!)(\(currency.name!))"
//        sourceCurrencyButton.setTitle(currencyTitle, for: UIControlState.normal)
//        print("----", currencyTitle)
    }
}

