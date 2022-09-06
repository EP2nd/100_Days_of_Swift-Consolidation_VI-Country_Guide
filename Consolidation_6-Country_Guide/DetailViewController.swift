//
//  DetailViewController.swift
//  Consolidation_6-Country_Guide
//
//  Created by Edwin Przeźwiecki Jr. on 05/09/2022.
//

import UIKit

class DetailViewController: UITableViewController {
    var country = [Country]()
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Details"
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON() {
        let urlString: String
        
        //urlString = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=\(country.name)"
    }
}
