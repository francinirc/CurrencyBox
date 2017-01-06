//
//  BookmarksController.swift
//  CurrencyBox
//
//  Created by Francini Roberta de Carvalho on 8/20/16.
//  Copyright © 2016 Francini Carvalho. All rights reserved.
//

import UIKit

class BookmarksController: UITableViewController {

//    let values = [("EUR", "Euro", "€ 1.00"),
//                  ("USD", "US Dollar", "U$ 10,123"),
//                  ("GBP", "Great Britain Pound", "£ 5000,00"),
//                  ("EUR", "Euro", "€ 1.00"),
//                  ("USD", "US Dollar", "U$ 10,123"),
//                  ("GBP", "Great Britain Pound", "£ 5000,00"),
//                  ("EUR", "Euro", "€ 1.00"),
//                  ("USD", "US Dollar", "U$ 10,123"),
//                  ("GBP", "Great Britain Pound", "£ 5000,00")]

    let values = CurrencyDAO.getAllCurrencies()
    
    let cellIdentifier = "currencyIdentifier"
    
    
    // MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("Moedas selecionadas: ", CurrencyDAO.filteredCurrencies.count)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.values.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! CurrencyCell

        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.currencyLabel.text = "\(values[indexPath.row].initial!) (\(values[indexPath.row].name!))"
        cell.flagImageView.image = UIImage(named: values[indexPath.row].countryFlag!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        let currency = values[indexPath.row]
        
        if cell?.accessoryType == UITableViewCellAccessoryType.none {
            cell?.accessoryType = UITableViewCellAccessoryType.checkmark
            CurrencyDAO.filteredCurrencies.append(currency)
            
        } else {
            cell?.accessoryType = UITableViewCellAccessoryType.none
            
            let index = CurrencyDAO.filteredCurrencies.index { $0 === currency }
            CurrencyDAO.filteredCurrencies.remove(at: index!)
        }
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)
//        
//        let currency = values[indexPath.row]
//        
//        if cell?.accessoryType == UITableViewCellAccessoryType.none {
//            cell?.accessoryType = UITableViewCellAccessoryType.checkmark
//            CurrencyDAO.filteredCurrencies.append(currency)
//            
//        } else {
//            cell?.accessoryType = UITableViewCellAccessoryType.none
//            CurrencyDAO.filteredCurrencies.remove(at: indexPath.row)
//        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */



}
