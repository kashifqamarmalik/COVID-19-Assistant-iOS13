//
//  CountryDetailsTableViewController.swift
//  Covid-19App
//
//  Created by iosdev on 23.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit

class CountryDetailsTableViewController: UITableViewController, UISearchResultsUpdating {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

         self.clearsSelectionOnViewWillAppear = false
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by Country or city"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    
    var countryNames = [String]()

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return countryNames.count
    }

    

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "StatsTableViewCell", for: indexPath) as? StatsTableViewCell  else {
        fatalError("invalid cell type.")
    }
    
    return cell
    
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
           print("america")
   }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
