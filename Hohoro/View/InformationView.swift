//
//  InformationView.swift
//  Hohoro
//
//  Created by warit karn on 9/2/2568 BE.
//

import SwiftUI
private let piscesTheme = ThemeColors(
    primary: Color(hex: "#B10DC9"),    // Primary purple
    secondary: Color(hex: "#FFF0F5"),   // Light background
    text: Color.white                   // White text
)

struct InformationView: View {
    init() {
        // Make navigation bar transparent
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Apply to all navigation bars in this view
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        piscesTheme.primary,          // Purple
                        piscesTheme.primary.opacity(0.7),  // Faded purple
                        Color.black.opacity(0.8),     // Dark grey
                        Color.black                   // Pure black
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                VStack(spacing: 20) {
                    Image("InformationPic")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .frame(width: 250, height: 250)
                    
                    Text("What is Physiognomy?")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Physiognomy is the ancient practice of assessing a person's character or personality from their outer appearance, particularly the face. This practice has roots in many cultures worldwide.")
                        .foregroundColor(.white)
                    
                    Spacer()
                    NavigationLink(destination: DestinyView()) {
                        Text("Next")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundColor(piscesTheme.primary)
                            .frame(width: 200, height: 50)
                            .background(piscesTheme.text)
                            .cornerRadius(25)
                            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                    }
                    
                    
                }
                .padding(.horizontal, 10)
               
            }
            .background(Color.black.opacity(0.95))
            
            
        }
    
}
