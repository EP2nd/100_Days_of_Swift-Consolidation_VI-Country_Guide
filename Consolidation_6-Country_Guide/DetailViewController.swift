//
//  DetailViewController.swift
//  Consolidation_6-Country_Guide
//
//  Created by Edwin Przeźwiecki Jr. on 05/09/2022.
//

import UIKit

class DetailViewController: UITableViewController {
    var country: Country!
    var sections = ["Capital", "Language", "Area", "Pupulation", "Currency"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(country.name)"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        
        switch indexPath.section {
        case 0:
            guard let capital = country?.capital else {
                return cell
            }
            cell.textLabel?.text = capital
            return cell
        case 1:
            guard let language = country?.language else {
                return cell
            }
            cell.textLabel?.text = language
            return cell
        case 2:
            guard let area = country?.area else {
                return cell
            }
            cell.textLabel?.text = area
            return cell
        case 3:
            guard let population = country?.population else {
                return cell
            }
            cell.textLabel?.text = population
            return cell
        case 4:
            guard let currency = country?.currency else {
                return cell
            }
            cell.textLabel?.text = currency
            return cell
        default:
            cell.textLabel?.text = ""
            return cell
        }
    }
    
    @objc func shareTapped() {
        guard let country = country else { return }
        
        let countryFact = "Did you know that \(country.name)'s capital is \(country.capital), its official spoken language is \(country.language), its area amounts to \(country.area) and population to \(country.population), and that its currency is \(country.currency)? Well, now you know, thanks to Country Guide app! Check it out on the App Store!"
        
        let viewController = UIActivityViewController(activityItems: [countryFact], applicationActivities: [])
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(viewController, animated: true)
    }
}
