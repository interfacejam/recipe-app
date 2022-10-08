//
//  RecipeCategoryView.swift
//  Recipe List App
//
//  Created by Claudio Di Liberto on 05/10/2022.
//

import SwiftUI

struct RecipeCategoryView: View {
    
    @EnvironmentObject var model: RecipeModel
    
    @Binding var selectedTab: Int
    
    init(selectedTab: Binding<Int>) {
        
        self._selectedTab = selectedTab
        
        // Customize navigation bar font and size
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Avenir Heavy", size: 36)!]
    }
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading, spacing: 16){
                
                GeometryReader { geometry in
                    
                    ScrollView(showsIndicators: false) {
                        
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: Constants.gridSpacing, alignment: .topLeading), GridItem(.flexible(), spacing: Constants.gridSpacing, alignment: .topLeading)], alignment: .leading) {
                            
                            ForEach(Array(model.categories.sorted()), id:\.self) { category in
                                
                                Button(action: {
                                    
                                    // Set selected category
                                    model.selectedCategory = category
                                    
                                    // Switch tab to list view
                                    selectedTab = Constants.listTab
                                    
                                }, label: {
                                    
                                    
                                    VStack {
                                        
                                        Image(model.getCategoryImageName(category: category))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: (geometry.size.width - Constants.gridSpacing)/2, height: (geometry.size.width - Constants.gridSpacing)/2)
                                            .clipped()
                                            .cornerRadius(8)
                                        
                                        
                                        Text(category)
                                    }
                                })
                                .accentColor(.black)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Categories"))
            .padding(.top)
            .padding(.horizontal)
        }
    }
}

struct RecipeCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCategoryView(selectedTab: .constant(Constants.featuredTab))
            .environmentObject(RecipeModel())
    }
}
