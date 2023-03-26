//
//  ButtonBackgroundView.swift
//  Shiny Button
//
//  Created by Valentin Perignon on 25/03/2023.
//

import SwiftUI

struct ButtonBackgroundView: View {
    private var buttonPressedShapeStyle: some ShapeStyle {
        .shadow(.inner(color: .black.opacity(0.1), radius: 8, x: 0, y: 4))
        .shadow(.inner(color: .black.opacity(0.2), radius: 4, x: 0, y: 4))
        .shadow(.inner(color: .black.opacity(0.1), radius: 8, x: 0, y: -6))
        .shadow(.drop(color: .white.opacity(0.5), radius: 1, x: 0, y: -2))
        .shadow(.drop(color: .black.opacity(0.5), radius: 1, x: 0, y: -1))
        .shadow(.drop(color: .white.opacity(0.5), radius: 1, x: 0, y: -4))
        .shadow(.drop(color: .white.opacity(0.5), radius: 1, x: 0, y: 4))
        .shadow(.drop(color: .black.opacity(0.5), radius: 1, x: 0, y: 1))
        .shadow(.drop(color: .white.opacity(0.5), radius: 1, x: 0, y: 4))
    }
    
    private var buttonShapeStyle: some ShapeStyle {
        .shadow(.inner(color: .white, radius: 2, x: 0, y: 2))
        .shadow(.inner(color: .white.opacity(0.8), radius: 2, x: 0, y: 2))
        .shadow(.inner(color: .white.opacity(0.5), radius: 2, x: 0, y: -2))
        .shadow(.drop(color: .black.opacity(0.25), radius: 8, x: 0, y: 4))
        .shadow(.drop(color: .black.opacity(0.15), radius: 32, x: 0, y: 16))
        .shadow(.drop(color: .black.opacity(0.13), radius: 32, x: 0, y: 16))
    }
    
    let isPressed: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 56)
            .fill(isPressed ? AnyShapeStyle(buttonPressedShapeStyle) : AnyShapeStyle(buttonShapeStyle))
            .foregroundStyle(.ultraThinMaterial.opacity(0.5))
    }
}

struct ButtonBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonBackgroundView(isPressed: false)
    }
}
