//
//  Ingredient.swift
//  Recipe List App
//
//  Created by Claudio Di Liberto on 10/05/2022.
//

import Foundation

struct Ingredient: Identifiable, Decodable, Hashable {
    
    var id:UUID?
    var name: String
    var amount_whole: String?
    var amount_fraction: String?
    var unit: String?
    
}
