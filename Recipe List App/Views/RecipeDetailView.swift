//
//  RecipeDetailView.swift
//  Recipe List App
//
//  Created by Claudio Di Liberto on 02/05/2022.
//

import SwiftUI

struct RecipeDetailView: View {
    
    @EnvironmentObject var model: RecipeModel
    
    var recipe: Recipe
    var paddingTop: Double?
    
    @State private var selectedServingsSize:Int = 2
    
    var body: some View {
        
        ScrollView {
            
            VStack (alignment: .leading) {
                
                Text(recipe.name)
                    .largeTitleStyle()
                    .padding([.top, .horizontal])
                    .padding(.bottom, 8)
            
                Text(recipe.description)
                    .bodyRegularStyle()
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
                            .caption1Style()
                        
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
                            .titleStyle()
                            .padding(.bottom, 4.0)
                        
                        
                        ForEach(recipe.ingredients){ item in
                            
                            HStack(alignment: .top) {
                                Text("•")
                                Text(model.getPortion(ingredient: item, recipeServings: recipe.servings, targetServings: selectedServingsSize))
                            }
                            .bodyRegularStyle()
                        }
                        
                    }
                    
                    // MARK: Directions
                    VStack(alignment: .leading) {
                        Text("Method")
                            .titleStyle()
                            .padding(.bottom, 4.0)
                        
                        
                        ForEach(0..<recipe.directions.count, id: \.self){ i in
                            
                            HStack(alignment: .top, spacing: 16.0){
                                Image(systemName: "\(i + 1).circle.fill").imageScale(.large)
                                    .foregroundColor(.gray)
                                
                                Text(recipe.directions[i])
                                    .bodyRegularStyle()
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
            .environmentObject(model)
    }
}
