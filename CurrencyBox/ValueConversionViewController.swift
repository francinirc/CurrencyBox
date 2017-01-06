//
//  ValueConversionViewController.swift
//  CurrencyBox
//
//  Created by Francini Roberta de Carvalho on 8/18/16.
//  Copyright © 2016 Francini Carvalho. All rights reserved.
//

import UIKit

class ValueConversionViewController: UIViewController {

    // Outlets
    @IBOutlet weak var convertedValuesTableView: UITableView!
    @IBOutlet weak var valueToConvert: UITextField!
    
    
    // ViewController constants
    let cellIdentifier = "convertedValues"
    
    
    var values = [Currency]()
    
    
    // ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.convertedValuesTableView.dataSource = self
        print(Helpful.getCurrentCurrencySymbol())
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
        //let numberOfCurrenciesToConvert = self.convertedValuesTableView.visibleCells.count
        convertedValuesTableView.reloadData()
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
