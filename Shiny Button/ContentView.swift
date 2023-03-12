//
//  ContentView.swift
//  Shiny Button
//
//  Created by Valentin Perignon on 04/03/2023.
//

import SwiftUI

struct ShinyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 48, weight: .medium))
            .foregroundColor(Color("textColor"))
            .padding(.horizontal, 72)
            .padding(.vertical, 24)
            .background(
                background(isPressed: configuration.isPressed)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut, value: configuration.isPressed)
    }
    
    @ViewBuilder private func background(isPressed: Bool) -> some View {
        if isPressed {
            RoundedRectangle(cornerRadius: 56)
                .fill(
                    .shadow(.inner(color: .black.opacity(0.1), radius: 8, x: 0, y: 4))
                    .shadow(.inner(color: .black.opacity(0.2), radius: 4, x: 0, y: 4))
                    .shadow(.inner(color: .black.opacity(0.1), radius: 8, x: 0, y: -6))
                    .shadow(.drop(color: .white.opacity(0.5), radius: 1, x: 0, y: -2))
                    .shadow(.drop(color: .black.opacity(0.5), radius: 1, x: 0, y: -1))
                    .shadow(.drop(color: .white.opacity(0.5), radius: 1, x: 0, y: -4))
                    .shadow(.drop(color: .white.opacity(0.5), radius: 1, x: 0, y: 4))
                    .shadow(.drop(color: .black.opacity(0.5), radius: 1, x: 0, y: 1))
                    .shadow(.drop(color: .white.opacity(0.5), radius: 1, x: 0, y: 4))
                )
                .foregroundStyle(.ultraThinMaterial)
        } else {
            RoundedRectangle(cornerRadius: 56)
                .fill(
                    .shadow(.inner(color: .white, radius: 2, x: 0, y: 2))
                    .shadow(.inner(color: .white.opacity(0.8), radius: 2, x: 0, y: 2))
                    .shadow(.inner(color: .white.opacity(0.5), radius: 2, x: 0, y: -2))
                    .shadow(.drop(color: .black.opacity(0.25), radius: 8, x: 0, y: 4))
                    .shadow(.drop(color: .black.opacity(0.15), radius: 32, x: 0, y: 16))
                    .shadow(.drop(color: .black.opacity(0.13), radius: 32, x: 0, y: 16))
                )
                .foregroundStyle(.ultraThinMaterial)
        }
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()

            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(ShinyButtonStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
