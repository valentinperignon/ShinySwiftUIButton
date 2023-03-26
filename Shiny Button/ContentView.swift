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
            .background(ButtonBackgroundView(isPressed: configuration.isPressed))
            .background(
                VideoPreview()
                    .brightness(0.1)
                    .blur(radius: 4)
                    .saturation(0.3)
                    .opacity(0.5)
                    .clipShape(RoundedRectangle(cornerRadius: 56))
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut, value: configuration.isPressed)
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
