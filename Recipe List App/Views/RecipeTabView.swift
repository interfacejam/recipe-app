//
//  RecipeTabView.swift
//  Recipe List App
//
//  Created by Claudio Di Liberto on 08/05/2022.
//

import SwiftUI

struct RecipeTabView: View {
    
    @StateObject var model = RecipeModel()
    
    @State var selectedTab = Constants.featuredTab
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            RecipeFeaturedView()
                .tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("Featured")
                    }
                }
                .tag(Constants.featuredTab)
            
            RecipeCategoryView(selectedTab: $selectedTab)
                .tabItem {
                    VStack {
                        Image(systemName: "square.grid.2x2")
                        Text("Categories")
                    }
                }
                .tag(Constants.categoriesTab)
            
            RecipeListView()
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("Recipes")
                    }
                }
                .tag(Constants.listTab)
        }
        .environmentObject(model)
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
            .environmentObject(RecipeModel())
    }
}

