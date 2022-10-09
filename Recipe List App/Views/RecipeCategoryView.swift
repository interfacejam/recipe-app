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
            
            VStack {
                
                GeometryReader { geometry in
                    
                    ScrollView(showsIndicators: false) {
                        
                        let colums = [
                            GridItem(spacing: Constants.gridSpacing),
                                GridItem(spacing: 0)
                            ]
                        
                        let categoryCardLabelHeight: CGFloat = 40
                        
                        LazyVGrid(columns: colums, spacing: Constants.gridSpacing) {
                            
                            ForEach(Array(model.categories.sorted()), id:\.self) { category in
                                
                                Button(action: {
                                    
                                    // Set selected category
                                    model.selectedCategory = category
                                    
                                    // Reset list view
                                    model.resetListView = true
                                    
                                    // Switch tab to list view
                                    selectedTab = Constants.listTab
                                    
                                    
                                }, label: {
                                    
                                    VStack(spacing: 0) {
                                        
                                        Image(model.getCategoryImageName(category: category))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: ((geometry.size.width - Constants.gridSpacing * 2) / 2) - Constants.gridSpacing / 2,
                                                   height: ((geometry.size.width - Constants.gridSpacing * 2) / 2) - (categoryCardLabelHeight + Constants.gridSpacing / 2))
                                            .clipped()
                                        
                                        Text(category)
                                            .bodyBoldStyle()
                                            .frame(height: categoryCardLabelHeight, alignment: .center)
                                        
                                    }
                                    .background(.white)
                                    .cornerRadius(8)
                                    .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 6, x: 0, y: 0)
                                })
                                .accentColor(.black)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)

                    }
                }
            }
            .navigationBarTitle(Text("Categories"))
        }
    }
}


struct RecipeCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCategoryView(selectedTab: .constant(Constants.featuredTab))
            .environmentObject(RecipeModel())
    }
}
