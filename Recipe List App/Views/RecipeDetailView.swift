//
//  RecipeDetailView.swift
//  Recipe List App
//
//  Created by Claudio Di Liberto on 02/05/2022.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe: Recipe
    var paddingTop: Double?
    
    @State private var selectedServingsSize:Int = 2
    
    var body: some View {
        
        ScrollView {
            
            VStack (alignment: .leading) {
                
                Text(recipe.name)
                    .font(.largeTitle)
                    .bold()
                    .padding()

             
                Text(recipe.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .bottom])
                
                // MARK: Recipe image
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                
                // MARK: Ingredients
                VStack(alignment: .leading, spacing: 24.0){
                
                    VStack(alignment: .leading) {
                        
                        Text("Select your serving size:")
                            .font(.callout)
                        
                        Picker("Select servings", selection: $selectedServingsSize) {
                            Text("2").tag(2)
                            Text("4").tag(4)
                            Text("6").tag(6)
                            Text("8").tag(8)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 180)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.bottom, 4.0)
                        
                        
                        ForEach(recipe.ingredients, id: \.self){ item in
                            
                            HStack(alignment: .top) {
                                Text("•")
                                Text(RecipeModel.getPortion(ingredient: item, recipeServings: recipe.servings, targetServings: selectedServingsSize))
                            }
                        }
                        
                    }
                    
                    // MARK: Directions
                    VStack(alignment: .leading) {
                        Text("Method")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.bottom, 4.0)
                        
                        
                        ForEach(0..<recipe.directions.count, id: \.self){ index in
                            
                            HStack(alignment: .top, spacing: 16.0){
                                Text(String(index + 1))
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Text(recipe.directions[index])
                            }
                            .padding(.bottom, 1)
                            
                        }
                    }
                    
                }
                .padding(16)
                
            }
            .padding(.top, paddingTop ?? 0)

        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        // added for building purposes
        let model = RecipeModel()
        
        RecipeDetailView(recipe: model.recipes[0])
            .previewInterfaceOrientation(.portrait)
    }
}
