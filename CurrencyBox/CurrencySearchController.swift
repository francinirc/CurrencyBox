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
    var filteredItems = [Currency]()
    var values = [Currency]()
    var delegate: CurrencySearchControllerDelegate?
    
    
    // MARK: ViewController constants
    let cellIdentifier = "cellSearch"
    
    
    // MARK: ViewController lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        values = CurrencyDAO.getAllCurrencies()
        tableView.tableHeaderView = searchController.searchBar
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredItems.count
        }
        return self.values.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        if searchController.isActive && searchController.searchBar.text != "" {
            cell.textLabel?.text = filteredItems[indexPath.row].initial! + " - " + filteredItems[indexPath.row].name!
        } else {
            cell.textLabel?.text = values[indexPath.row].initial! + " - " + values[indexPath.row].name!
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getSelectedCurrency(currency: values[indexPath.row])
        print("passou")
        
    }


    // Class methods
    
    // Search bar
    func setupSearchBar() {
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
    }

}

extension CurrencySearchController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }

}

extension CurrencySearchController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
        
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        filteredItems = values.filter({( item: Currency) -> Bool in
            let itemMatch = (scope == "All") || (item.name == scope)
            return itemMatch && (item.name?.lowercased().contains(searchText.lowercased()))!
        })
        
        tableView.reloadData()
    }
}
