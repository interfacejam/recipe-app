//
//  ContentView.swift
//  Recipe List App
//
//  Created by Claudio Di Liberto on 01/05/2022.
//

import SwiftUI

struct RecipeListView: View {
    
    @ObservedObject var model = RecipeModel()
    
    var body: some View {
        
        NavigationView{
        
            List(model.recipes) { r in
            
                NavigationLink(
                    destination: RecipeDetailView(recipe: r),
                    label: {
                        HStack(spacing: 16.0){
                            Image(r.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50, alignment: .center)
                                .clipped()
                                .cornerRadius(8)
                            
                            Text(r.name)
                        }
                    }
                )
                
            }
            .navigationBarTitle(Text("Recipes"))
            
        }
        .navigationViewStyle(.stack)
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
