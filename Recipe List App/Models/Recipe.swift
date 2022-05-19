//
//  Recipe.swift
//  Recipe List App
//
//  Created by Claudio Di Liberto on 01/05/2022.
//

import Foundation

struct Recipe: Identifiable, Decodable {
    
    var id:UUID?
    var name: String
    var featured: Bool
    var image: String
    var description: String
    var prepTime: String
    var cookTime: String
    var servings: String
    var highlights: [String]
    var ingredients: [Ingredient]
    var directions: [String]
}
