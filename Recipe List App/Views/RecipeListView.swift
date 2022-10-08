//
//  ContentView.swift
//  Recipe List App
//
//  Created by Claudio Di Liberto on 01/05/2022.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var model:RecipeModel
    
    init() {
        // Customize navigation bar font and size
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Avenir Heavy", size: 36)!]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        //UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]
    }
    
    
    private var title: String {
        
        if model.selectedCategory == nil || model.selectedCategory == Constants.defaultListFilter {
            return "All recipes"
        }
        else
        {
            return model.selectedCategory!
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            ScrollView{
                
                LazyVStack (alignment: .leading) {
                    ForEach(model.recipes) { r in
                        
                        if model.selectedCategory == nil ||
                            model.selectedCategory == Constants.defaultListFilter ||
                            r.category == model.selectedCategory {
                            
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
                                        
                                        VStack (alignment: .leading, spacing: 0){
                                            Text(r.name)
                                                .bodyBoldStyle()
                                            
                                            Text(model.getHighlights(highlights: r.highlights))
                                                .caption1Style()
                                        }
                                        .foregroundColor(.black)
                                    }
                                }
                            )
                            
                        }
                    }
                }
                .padding(.top)
                
            }
            .padding(.horizontal)
            .navigationBarTitle(Text(title))
            .navigationBarItems(
                trailing:
                    Button(action: {
                        model.selectedCategory = nil
                    }, label: {
                        Text(model.selectedCategory == nil || model.selectedCategory == Constants.defaultListFilter ? "" : "Clear filters")
                    })
            )
        }
        //.navigationViewStyle(.stack)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeModel())
    }
}
