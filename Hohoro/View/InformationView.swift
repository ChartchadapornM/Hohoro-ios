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
        ScrollView {
            VStack(spacing: 20) {
                Image("InformationPic")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(12)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("What is Physiognomy?")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Physiognomy is the ancient practice of assessing a person's character or personality from their outer appearance, particularly the face. This practice has roots in many cultures worldwide, including:")
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        PhysiognomyPoint(title: "Face Reading", description: "Analysis of facial features including shape, size, and positioning of eyes, nose, mouth, and other features.")
                        
                        PhysiognomyPoint(title: "Historical Significance", description: "Practiced in ancient China, Greece, and many other civilizations as a way to understand human nature.")
                        
                        PhysiognomyPoint(title: "Modern Applications", description: "While not scientifically proven, some use it for personal insights and understanding of facial expressions.")
                        
                        PhysiognomyPoint(title: "Key Features", description: "Examines facial symmetry, proportions, and specific features like eyebrows, chin, and forehead shape.")
                    }
                }
                .padding()
            }
            NavigationLink(destination: SecondView()) {
                                    Text("Let's find your destiny.")
                                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                                        .foregroundColor(piscesTheme.primary)
                                        .frame(width: 200, height: 50)
                                        .background(piscesTheme.text)
                                        .cornerRadius(25)
                                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                                }
        }
        .background(Color.black.opacity(0.95))
        .navigationBarTitle("Physiognomy", displayMode: .inline)
        
    }
}
