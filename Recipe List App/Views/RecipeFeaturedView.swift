//
//  RecipeFeaturedView.swift
//  Recipe List App
//
//  Created by Claudio Di Liberto on 12/05/2022.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @EnvironmentObject var model: RecipeModel
    
    @State private var featuredRecipes: Bool = false
    @State private var selectedFeaturedIndex = 0
    @State private var detailViewShown = false
    
    var body: some View {
    
        // Create an array of featured recipes
        let featuredRecipes = model.recipes.filter({ $0.featured })
        
        VStack (alignment: .leading, spacing: 0) {
            
            Text("Featured recipes")
                .largeTitleStyle()
                .padding(.horizontal)
            
            // If there is at least one featured recipe
            if !featuredRecipes.isEmpty {
                
                TabView(selection: $selectedFeaturedIndex) {
                    
                    ForEach(0..<featuredRecipes.count, id:\.self) { r in
                        
                        let recipe = featuredRecipes[r]
                        
                        Button {
                            detailViewShown = true
                        } label: {
                            // Recipe card
                            VStack(spacing: 0) {
                                
                                Image(recipe.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: UIScreen.main.bounds.width - 32)
                                
                                Text(recipe.name)
                                    .bodyBoldStyle()
                                    .padding()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.white)
                            .cornerRadius(8)
                            .padding([.horizontal, .top])
                            .padding(.bottom, 48)
                            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 6, x: 0, y: 0)
                        }
                        .buttonStyle(.plain)
                       
                    }
                }
                .frame(maxHeight: UIScreen.main.bounds.height / 3 * 2)
                .tabViewStyle(.page)
                .onAppear {
                    setupAppearance()
                }
                //.indexViewStyle(.page(backgroundDisplayMode: .automatic))
                
                VStack (alignment: .leading, spacing: 8) {
                    
                    let selectedRecipe = featuredRecipes[selectedFeaturedIndex]
                    
                    VStack (alignment: .leading) {
                        Text("Preparation time")
                            .bodyBoldStyle()
                            
                        
                        Text(selectedRecipe.prepTime)
                            .caption1Style()
                        
                        
                    }
                       
                    VStack (alignment: .leading) {
                        Text("Highlights")
                            .bodyBoldStyle()
                        
                        Text(model.getHighlights(highlights: selectedRecipe.highlights))
                            .caption1Style()
                    }
                }
                .padding([.horizontal, .bottom])
                
            }
            else
            {
                Spacer()
                VStack (spacing: 24) {
                    Image(systemName: "xmark.bin")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 120)
                        .font(Font.body.weight(.light))
                        
                    Text("No featured content available")
                    
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }
        }
        .padding(.top, 32)
        .sheet(isPresented: $detailViewShown) {
            
            RecipeDetailView(recipe: featuredRecipes[selectedFeaturedIndex], paddingTop: 24)
        }
        
    }
    
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        UIPageControl.appearance().backgroundStyle = .automatic
    }
    
    
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}
