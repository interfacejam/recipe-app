//
//  Ingredient.swift
//  Recipe List App
//
//  Created by Claudio Di Liberto on 10/05/2022.
//

import Foundation

struct Ingredient: Identifiable, Decodable {
    
    var id: UUID?
    var name: String
    var amount: String?
    var unit: String?

}
