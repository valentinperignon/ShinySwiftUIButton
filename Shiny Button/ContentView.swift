//
//  ContentView.swift
//  Shiny Button
//
//  Created by Valentin Perignon on 04/03/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()

            Button(action: {}) {
                Text("Button")
                    .font(.system(size: 48, weight: .medium))
                    .foregroundColor(Color("textColor"))
                    .padding(.horizontal, 72)
                    .padding(.vertical, 24)
            }
            .background(
                RoundedRectangle(cornerRadius: 56)
                    .fill(
                        .shadow(.inner(color: .white, radius: 2, x: 0, y: 2))
                        .shadow(.inner(color: .white.opacity(0.8), radius: 2, x: 0, y: 2))
                        .shadow(.inner(color: .white.opacity(0.5), radius: 2, x: 0, y: -2))
                    )
                    .foregroundColor(Color("backgroundColor"))
            )
            .cornerRadius(56)
            .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 4)
            .shadow(color: .black.opacity(0.15), radius: 32, x: 0, y: 16)
            .shadow(color: .black.opacity(0.13), radius: 32, x: 0, y: 16)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
