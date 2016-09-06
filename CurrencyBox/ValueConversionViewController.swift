//
//  ValueConversionViewController.swift
//  CurrencyBox
//
//  Created by Francini Roberta de Carvalho on 8/18/16.
//  Copyright © 2016 Francini Carvalho. All rights reserved.
//

import UIKit

class ValueConversionViewController: UIViewController, UITableViewDataSource {

    // Outlets
    @IBOutlet weak var convertedValuesTableView: UITableView!
    
    
    // ViewController constants
    let cellIdentifier = "convertedValues"
    
    
    let values = [("EUR", "Euro", "€ 1.00"),
                  ("USD", "US Dollar", "U$ 10,123"),
                  ("GBP", "Great Britain Pound", "£ 5000,00")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.convertedValuesTableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: TableView Datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.values.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier, forIndexPath: indexPath) as! ConvertedValuesCell
        
        cell.flagImageView.image = UIImage(named: "usa-flag")
        cell.initialsLabel.text = self.values[indexPath.row].0
        cell.currencyNameLabel.text = self.values[indexPath.row].1
        cell.convertedValueLabel.text = self.values[indexPath.row].2
        
        return cell
        
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Valores convertidos:"
    }

    // MARK: Unwind Segues
    @IBAction func cancelToValueConversionViewController(segue:UIStoryboardSegue) {
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
