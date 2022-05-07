//
//  RecipeDetailView.swift
//  Recipe List App
//
//  Created by Claudio Di Liberto on 02/05/2022.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe: Recipe
    
    var body: some View {
        
        ScrollView {
            
            VStack {
             
                Text(recipe.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                
                VStack(alignment: .leading, spacing: 24.0){
                
                    VStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.bottom, 4.0)
                        
                        ForEach(recipe.ingredients, id: \.self){ item in
                            
                            HStack(alignment: .top, spacing: 4.0){
                                Text("•")
                                Text(item)
                            }
                            .padding(.bottom, 1)
                        }
                    }
                    
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
            .padding(.top, 12.0)
        }
        .navigationBarTitle(recipe.name)
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
