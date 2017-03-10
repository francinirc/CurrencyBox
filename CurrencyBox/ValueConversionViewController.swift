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
    var sourceCurrency = Currency(newName: "Brazilian Real", newInitial: "BRL", newCountryFlag: "", newSymbol: "R$") // por padrão, carregar a moeda configurada no telefone
    var values = [Double]()
    
    
    // MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.convertedValuesTableView.dataSource = self
        print(Helper.getCurrentCurrencySymbol())
    }

    override func viewWillAppear(_ animated: Bool) {
        bookmarkedCurrencies = CurrencyDAO.filteredCurrencies //CurrencyDAO.getAllCurrencies()
        getRates()
    }
   

    // MARK: Unwind Segues
    @IBAction func cancelToValueConversionViewController(_ segue:UIStoryboardSegue) {
    }
    
    
    // MARK: Actions
    
    @IBAction func convertCurrencies(_ sender: AnyObject) {
        if valueToConvert.text!.isEmpty {
            showAlert(message: "Informe um valor para converter.")
            
        } else {
            getRates()
        }
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
    
    func getRates() {
        FixerioAPIService.getLatestRates(fromCurrency: sourceCurrency.initial!, toCurrencies: bookmarkedCurrencies) { (convertion, error) in
            if let convertion = convertion {
                //self.values = convertion.currencies!
                
                DispatchQueue.main.async {
                    self.convertValues(convertion: convertion)
                    self.convertedValuesTableView.reloadData()
                    print("atualizou")
                }
            }
        }
    }
    
    func convertValues(convertion: Convertion) {
        if !valueToConvert.text!.isEmpty {
            let baseValue = Double(valueToConvert.text!)

            for i in 0...convertion.currencies!.count - 1 {
                let value = convertion.currencies![i].rate! * baseValue!
                values.append(value)
            }
            
            print("values = ", values.count)
        } else {
            
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
        cell.initialsLabel.text = self.bookmarkedCurrencies[indexPath.row].initial
        cell.currencyNameLabel.text = self.bookmarkedCurrencies[indexPath.row].name
        print(bookmarkedCurrencies.count)
        print(values.count)
        
        if bookmarkedCurrencies.count > 0 && values.count > 0 {
            cell.convertedValueLabel.text = self.bookmarkedCurrencies[indexPath.row].symbol! + " " + String(values[indexPath.row])
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
        
        let currencyTitle = "\(currency.symbol!) - \(currency.initial!)(\(currency.name!))"
        sourceCurrencyButton.setTitle(currencyTitle, for: UIControlState.normal)
        print("----", currencyTitle)
    
    }
}

