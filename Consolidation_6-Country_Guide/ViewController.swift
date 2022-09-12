//
//  ViewController.swift
//  Consolidation_6-Country_Guide
//
//  Created by Edwin Przeźwiecki Jr. on 05/09/2022.
//

import UIKit

class ViewController: UITableViewController {
    var country = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Country Guide"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(openTapped))
        
        performSelector(inBackground: #selector(loadData), with: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return country.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        guard let cell = reusableCell as? CountryCell else {
            return reusableCell
        }
        
        let country = country[indexPath.row]
        
        cell.textLabel?.text = country.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailViewController.country = country[indexPath.row]
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    /* @objc func fetchJSON() {
        let urlString: String
        
        urlString = "https://restcountries.com/v3.1/all?fields=name;flag;capital;language;area;population;currency"
        
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
            country = jsonCountriesList.results
            
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    } */
    
    @objc func loadData() {
        let urlString = "https://restcountries.com/v3.1/all?fields=name;flag;capital;language;area;population;currency"
        
        if let url = URL(string: urlString) {
            do {
                let data = try Data(contentsOf: url)
                let jsonCountries = try JSONDecoder().decode([Country].self, from: data)
                country = jsonCountries
            }
            catch {
                showError()
            }
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
        let alertController = UIAlertController(title: "Credits", message: "The data comes from REST Countries website.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true)
    }
}

