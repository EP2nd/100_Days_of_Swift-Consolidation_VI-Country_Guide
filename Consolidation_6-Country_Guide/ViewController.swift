//
//  ViewController.swift
//  Consolidation_6-Country_Guide
//
//  Created by Edwin Przeźwiecki Jr. on 05/09/2022.
//

import UIKit

class ViewController: UITableViewController {
    var country = [Country]()
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Country Guide"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(openTapped))
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let country = country[indexPath.row]
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.flag
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
        }
    }
    
    @objc func fetchJSON() {
        let urlString: String
        
        urlString = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=List_of_countries_and_dependencies_by_area"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                self.parse(json: data)
                return
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonCountriesList = try? decoder.decode(Countries.self, from: json) {
            countries = jsonCountriesList.results
            
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    @objc func showError() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
    }
    
    @objc func openTapped() {
        let alertController = UIAlertController(title: "Credits", message: "The data comes from Wikipedia.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true)
    }
}

