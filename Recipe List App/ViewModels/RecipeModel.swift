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
             
        // Populate the array with the data
        self.recipes = DataService.getLocalData()
    }
    
    func getPortion(ingredient: Ingredient, recipeServings:String, targetServings:Int ) -> String {
        
        var amount = ingredient.amount ?? ""
        let unit = ingredient.unit?.lowercased()
        var wholePortion: Int = 1
        var num: Int = 1
        var den: Int = 1
        
        //MARK: Parse the string and collect the values
        
        // If an amount is defined collect the numbers
        if ingredient.amount != nil {
            
            // Get the whole portion
            let amountString = amount.components(separatedBy: " ")
                
            wholePortion = Int(amountString[0]) ?? 0
            
            if wholePortion == 0  {
                
                // It's a fraction
                let fractionString = amountString[0].components(separatedBy: "/")
                
                num = Int(fractionString[0]) ?? 0
                den = Int(fractionString[1]) ?? 0
                
            } else {
                // It's a whole
                num = wholePortion
            }
            
            // If it's a mixed number
            if amountString.count > 1 {
                
                let fractionString = amountString[1].components(separatedBy: "/")
                
                num = Int(fractionString[0]) ?? 0
                den = Int(fractionString[1]) ?? 0
                
                // Get the improper number
                num += wholePortion * den
            
            }
            
            // calculate the correct amount
            amount = calculatePortion(num: num, den: den, recipeServings: recipeServings, targetServings: targetServings)
    
            if unit != nil {
                amount += " " + unit! + " of"
            }
            
            amount += " " + ingredient.name.lowercased()
        }
        
        else
        // If there's no amount
        {
            amount = ingredient.name
            
            if unit != nil {
                amount += " " + unit!
            }
        }
        
        return amount
    }
    
    //MARK: Calculate the portions
    
    private func calculatePortion(num:Int, den:Int, recipeServings: String, targetServings:Int) -> String {
        
        var wholePortion: Int = 0
        var num: Int = num
        var den: Int = den
        
        let recipeServings = Int(recipeServings) ?? 0
        var portion: String = ""
        
        // Get the single portion and multiply by the number of servings
        num *= targetServings
        den *= recipeServings
        
        // Find the greatest common divisor
        let divisor = Rational.greatestCommonDivisor(num, den)
        
        // Simplify the fraction
        num /= divisor
        den /= divisor
        
        // Turn the improper number into a mixed number
        if num >= den {
            wholePortion = num / den
            num %= den
            
            portion = String(wholePortion)
            
            // Express the remainder as a fraction
            if num > 0 {
                portion = String("\(wholePortion)  \(num)/\(den)")
            }
        
        }
        else
        {
            portion += String("\(num)/\(den)")
        }
        
        return portion
    }
    
    func getHighlights(highlights:[String]) -> String {
        
        var highlightsString: String = ""
        var separator: String
                
        for i in 0..<highlights.count {
            
            separator = i < highlights.count-1 ? ", " : ""
            
            highlightsString += highlights[i] + separator
        }
        
        return highlightsString
    }

}




