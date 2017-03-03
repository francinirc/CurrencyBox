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
    
    
    var values = [Currency]()
    
    
    // ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.convertedValuesTableView.dataSource = self
        print(Helper.getCurrentCurrencySymbol())
        
        FixerioAPIService.getLatestRates(fromCurrency: "USD") { (convertion, error) in
            if let convertion = convertion {
                self.values = convertion.currencies!
                
                DispatchQueue.main.async {
                    self.convertedValuesTableView.reloadData()
                    print("atualizou")
                }
            }
            
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        convertedValuesTableView.reloadData()
        values = CurrencyDAO.getAllCurrencies()
        
        print(values.count)
    }
   

    // MARK: Unwind Segues
    @IBAction func cancelToValueConversionViewController(_ segue:UIStoryboardSegue) {
    }
    
    
    // MARK: Actions
    
    @IBAction func convertCurrencies(_ sender: AnyObject) {
        convertedValuesTableView.reloadData()
    }
    
    
    // MARK: - Navigation
    
    //func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "selectCurrencySegue" {
            
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! CurrencySearchController
            
            targetController.delegate = self            
        }
    }

}



extension ValueConversionViewController: UITableViewDataSource {
    
    // MARK: TableView Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if values.count > 0 {
            return self.values.count
        } else {
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
        
        cell.flagImageView.image = UIImage(named: self.values[indexPath.row].countryFlag!)
        cell.initialsLabel.text = self.values[indexPath.row].initial
        cell.currencyNameLabel.text = self.values[indexPath.row].name
        let valor = 1000.00
        cell.convertedValueLabel.text = self.values[indexPath.row].symbol! + " " + String(valor)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Última atualização em: \(Date.init().toStringFullFormat())"
    }
    
}


extension ValueConversionViewController: CurrencySearchControllerDelegate {
    
    func getSelectedCurrency(currency: Currency) {
        let currencyTitle = "\(currency.symbol!) - \(currency.initial!)(\(currency.name!))"
        sourceCurrencyButton.setTitle(currencyTitle, for: UIControlState.normal)
        print("----", currencyTitle)
    
    }
}

