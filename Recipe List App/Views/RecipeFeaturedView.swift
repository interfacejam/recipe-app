//
//  RecipeFeaturedView.swift
//  Recipe List App
//
//  Created by Claudio Di Liberto on 12/05/2022.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @EnvironmentObject var model:RecipeModel
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 0) {
            
            Text("Featured recipes")
                .font(.largeTitle)
                .bold()
                .padding(.top, 49.5)
                .padding(.horizontal)
            
            TabView {
                
                ForEach(model.recipes) { r in
                    
                    if r.featured {
                    
                            VStack(spacing: 0) {
                                
                                Image(r.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: UIScreen.main.bounds.width - 32)
                                
                                Text(r.name)
                                    .padding()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.white)
                            .cornerRadius(8)
                            .padding([.horizontal, .top])
                            .padding(.bottom, 48)
                            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 6, x: 0, y: 0)

                    }
                }
            }
            .frame(maxHeight: UIScreen.main.bounds.height / 3 * 2)
            .tabViewStyle(.page)
            .onAppear {
                setupAppearance()
            }
            //.indexViewStyle(.page(backgroundDisplayMode: .always))
            
            VStack (alignment: .leading, spacing: 8) {
                
                Text("Preparation time")
                    .font(.headline)
                
                Text("1 hr")
                
                Text("Highlights")
                    .font(.headline)
                
                Text("Healthy, hearty")
                
            }
            .padding([.horizontal, .bottom])
            
        }

    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}
