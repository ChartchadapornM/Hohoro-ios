//
//  ContentView.swift
//  Hohoro
//
//  Created by warit karn on 9/2/2568 BE.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // Pisces theme colors
    private let piscesTheme = ThemeColors(
        primary: Color(hex: "#B10DC9"),    // Primary purple
        secondary: Color(hex: "#FFF0F5"),   // Light background
        text: Color.white                   // White text
    )
    @State private var isRotating = 0.0
    var body: some View {
        NavigationStack{
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
                
                // Content
                VStack(spacing: 30) {
                    Spacer() // Add spacer at top to push content down
                    
                    VStack {
                        Image("HohoroLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .rotationEffect(.degrees(isRotating))
                            .onAppear {
                                withAnimation(
                                    .linear(duration: 6)
                                    .repeatForever(autoreverses: false)
                                ) {
                                    isRotating = 360.0
                                }
                            }
                        
                        // App name with custom styling
                        Text("Hohoro")
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundColor(piscesTheme.text)
                            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                    }
                    
                    Spacer() // Add spacer to create equal space above and below
                    
                    NavigationLink(destination: InformationView()) {
                                            Text("Let's start")
                                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                                .foregroundColor(piscesTheme.primary)
                                                .frame(width: 200, height: 50)
                                                .background(piscesTheme.text)
                                                .cornerRadius(25)
                                                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                                        }
                                        
                                        Spacer().frame(height: 50)
                                    }
               
                
                }
            }
        }
    }

