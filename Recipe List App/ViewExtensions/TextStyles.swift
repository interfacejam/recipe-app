//
//  TextStyles.swift
//  Recipe List App
//
//  Created by Claudio Di Liberto on 23/05/2022.
//

import SwiftUI

struct LargeTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Avenir Heavy", size: 36))
    }
}

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Avenir Heavy", size: 24))
    }
}

struct BodyRegularStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Avenir", size: 18))
    }
}

struct BodyBoldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Avenir Heavy", size: 18))
    }
}

struct Caption1Style: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Avenir", size: 16))
    }
}

extension View {
    
    func largeTitleStyle() -> some View {
        modifier(LargeTitleStyle())
    }
    
    func titleStyle() -> some View {
        modifier(TitleStyle())
    }
    
    func bodyRegularStyle() -> some View {
        modifier(BodyRegularStyle())
    }
    
    func bodyBoldStyle() -> some View {
        modifier(BodyBoldStyle())
    }
    
    func caption1Style() -> some View {
        modifier(Caption1Style())
    }
}
