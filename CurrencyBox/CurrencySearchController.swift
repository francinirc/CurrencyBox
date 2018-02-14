//
//  CurrencySearchController.swift
//  CurrencyBox
//
//  Created by Francini Roberta de Carvalho on 8/20/16.
//  Copyright © 2016 Francini Carvalho. All rights reserved.
//

import UIKit

// Protocols

protocol CurrencySearchControllerDelegate {
    
    func getSelectedCurrency(currency: Currency)
    
}

// Classes

class CurrencySearchController: UITableViewController {

    // MARK: Properties
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCurrencies = [Currency]()
    var currencies = [Currency]()
    var delegate: CurrencySearchControllerDelegate?
    //var delegate: ValueConversionViewController?
    
    // MARK: ViewController constants
    let cellIdentifier = "cellSearch"
    
    
    // MARK: ViewController lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        currencies = CurrencyDAO.getAllCurrencies()
        tableView.tableHeaderView = searchController.searchBar
        
       
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredCurrencies.count
        }
        return self.currencies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        if searchController.isActive && searchController.searchBar.text != "" {
            cell.textLabel?.text = filteredCurrencies[indexPath.row].code! + " - " + filteredCurrencies[indexPath.row].name!
        } else {
            cell.textLabel?.text = currencies[indexPath.row].code! + " - " + currencies[indexPath.row].name!
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getSelectedCurrency(currency: currencies[indexPath.row])
        _ = self.presentingViewController?.dismiss(animated: true, completion: nil)
        //_ = self.dismiss(animated: true, completion: nil)
        print("passou")
        print(currencies[indexPath.row].name!)
    }


    // MARK: Class methods
    
    // Search bar
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = UIColor.tealColor()
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
    }

}


extension CurrencySearchController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
    
}


extension CurrencySearchController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

        
    func filterContentForSearchText(_ searchText: String) {
        filteredCurrencies = currencies.filter({( item: Currency) -> Bool in
            return (item.name?.lowercased().contains(searchText.lowercased()))!
        })
        
        tableView.reloadData()
    }
        
    
}
