//
//  Country.swift
//  Consolidation_6-Country_Guide
//
//  Created by Edwin Przeźwiecki Jr. on 05/09/2022.
//

import Foundation

struct Country: Codable {
    var name: String
    var flag: String
    var capital: String
    var language: String
    var area: Double?
    var population: Double?
    var currency: String
}
