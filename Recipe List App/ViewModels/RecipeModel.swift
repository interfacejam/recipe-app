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
    
    static func getPortion(ingredient: Ingredient, recipeServings:String, targetServings:Int ) -> String {
        
        var whole: Int
        var num: Int
        var den: Int
        var unit: String = ""
        let name: String = ingredient.name.lowercased()
        
        let output:String
        
        if ingredient.unit != nil {
            unit = ingredient.unit!.lowercased()
        }
        
        // Get the single serving size by multiplying the denominator by the recipe servig size
        
        // it's a mixed number (whole + fraction)
        if ingredient.amount_whole != nil && ingredient.amount_fraction != nil {
            
            whole = Int(ingredient.amount_whole!)!
            
            let array = ingredient.amount_fraction?.components(separatedBy: "/")
            
            num = Int((array?[0])!)!
            den = Int((array?[1])!)!
            
            output = String(String(whole) + " " + String(num) + "/" + String(den) + " " + unit + " of " + name)
        }
        
        // it's a whole number
        else if ingredient.amount_whole != nil {
            
            whole = Int(ingredient.amount_whole!)!
            
            if unit != "" {
                
                output = String(String(whole) + " " + unit + " of " + name)
            }
            else
            {
                output = String(String(whole) + " " + name)
            }
            
            
        }
        
        // it's a fraction
        else if ingredient.amount_fraction != nil {
            
            let array = ingredient.amount_fraction?.components(separatedBy: "/")
            
            num = Int((array?[0])!)!
            den = Int((array?[1])!)!
            
            if unit != "" {
                
                output = String("\(num)/\(den)" + " " + unit + " of " + name)
            }
            else
            {
                output = String("\(num)/\(den)" + " " + name)
            }
            
            
            
        }
        else
        {
            output = String(name.capitalized + " " + unit)
        }
        
        
        return output
        
        // Get the target portions by multiplying the numerator by the target servings
        
        // Reduce the fraction by finding greatest common divisor (the highest number that can divide the numerator and denominator)
        
        // If the numerator is greater than the denominator get the whole portion (by dividing the numerator by the denominator and getting the remainder)
        
        // Express the remainder as a fraction
        
    }
}




