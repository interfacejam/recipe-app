//
//  RecipeFeaturedView.swift
//  Recipe List App
//
//  Created by Claudio Di Liberto on 12/05/2022.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @EnvironmentObject var model:RecipeModel
    
    @State private var selectedPage = 0
    @State private var detailViewShown = false
    @State private var isFeaturedContentAvailable = 0
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 0) {
            
            Text("Featured recipes")
                .font(.largeTitle)
                .bold()
                .padding(.horizontal)
            
            if isFeaturedContentAvailable != 0 {
                
                TabView(selection: $selectedPage) {
                    
                    ForEach(0..<model.recipes.count, id:\.self) { r in
                        
                        let recipe = model.recipes[r]
                        
                        if recipe.featured {
                            
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
                                        .font(.headline)
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
                            .sheet(isPresented: $detailViewShown) {
                                RecipeDetailView(recipe: recipe, paddingTop: 24)
                            }
                        }
                    }
                }
                .frame(maxHeight: UIScreen.main.bounds.height / 3 * 2)
                .tabViewStyle(.page)
                .onAppear {
                    setupAppearance()
                }
                //.indexViewStyle(.page(backgroundDisplayMode: .automatic))
                
                VStack (alignment: .leading, spacing: 8) {
                    
                    let recipe = model.recipes[selectedPage]
                    
                    Text("Preparation time")
                        .font(.headline)
                    
                    Text(recipe.prepTime)
                    
                    Text("Highlights")
                        .font(.headline)
                    
                    Text(RecipeModel.getHighlights(highlights: recipe.highlights))
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
        .onAppear(){
            setFeaturedIndex()
        }
        
    }
    
    func setFeaturedIndex() {
        
        // Find the index of the first recipe that is featured
        let index = model.recipes.firstIndex { recipe in
            return recipe.featured
        }
        // Update the selectedPage variable
        selectedPage = index ?? 0
        // Update this variable to check the existence of featured content
        isFeaturedContentAvailable = index ?? 0
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
