//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Claudio Di Liberto on 01/05/2022.
//

import Foundation

class RecipeModel: ObservableObject {
    
    @Published var recipes = [Recipe]()
    
    init() {
             
        // Set the recipes property
        self.recipes = DataService.getLocalData()
        
    }
}
