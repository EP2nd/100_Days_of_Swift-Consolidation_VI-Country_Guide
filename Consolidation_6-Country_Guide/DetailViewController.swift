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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Detail", for: indexPath)
        
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
            cell.textLabel?.text = "\(area)"
            return cell
        case 3:
            guard let population = country?.population else {
                return cell
            }
            cell.textLabel?.text = "\(population)"
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
}
