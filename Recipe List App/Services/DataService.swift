//
//  DataService.swift
//  Recipe List App
//
//  Created by Claudio Di Liberto on 01/05/2022.
//

import Foundation

class DataService {
    
    static func getLocalData() -> [Recipe] {
        
        // Parse local json file
        
        // Get URL path to json file
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
                
        
        // Check if pathString is not nit, otherwise...
        guard pathString != nil else {
            // return and empty array
            return [Recipe]()
        }
        
        let url = URL(fileURLWithPath: pathString!)

        do{
            // Create a data object
            let data = try Data(contentsOf: url)
            
            // Create a JSON decoder
            let decoder = JSONDecoder()
            
            // Decode json with a JSON decoder
            
            do{
                var recipeData = try decoder.decode([Recipe].self, from: data)
                
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
                print(error)
            }
            
        }
        catch {
            print(error)
        }
        return [Recipe]()
    }
    
}
