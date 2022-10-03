//
//  DataService.swift
//  Recipe List App
//
//  Created by Claudio Di Liberto on 01/05/2022.
//

import Foundation

class DataService {
    
    static func getLocalData() -> [Recipe] {
        
        let url = Bundle.main.url(forResource: "recipes", withExtension: "json")
        
        // Check if url is not nil
        guard url != nil else {
            print("JSON file not found")
            
            // Return an empty array
            return [Recipe]()
        }
        
        do {
            
            let data = try Data(contentsOf: url!)
            
            var recipeData = try JSONDecoder().decode([Recipe].self, from: data)
            
            // Add the unique ID to the recipes
            for r in 0..<recipeData.count {
                recipeData[r].id = UUID()
            
                for i in 0..<recipeData[r].ingredients.count {
                    recipeData[r].ingredients[i].id = UUID()
                }
                
            }
            // Return the recipes
            return recipeData
        }
        catch {
            print("Error retrieving data: \(error.localizedDescription)")
        }
        
        // Return an empty array
        return [Recipe]()
    }
}
