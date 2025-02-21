//
//  DestinyResultView.swift
//  Hohoro
//
//  Created by Warit Karnbunjob on 21/2/2568 BE.
//
import Foundation
import SwiftUI


private let piscesTheme = ThemeColors(
    primary: Color(hex: "#B10DC9"),    // Primary purple
    secondary: Color(hex: "#FFF0F5"),   // Light background
    text: Color.white                   // White text
)

struct DestinyResultView: View {
    @ObservedObject var viewModel: DestinyViewModel
    
    var body: some View {
        ZStack {
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
        ScrollView {

                VStack(spacing: 25) {
                    Text("Your Destiny Reading")
                        .font(.custom("Avenir-Heavy", size: 28))
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    // First Name Result
                    ResultCard(
                        title: "First Name Analysis",
                        name: viewModel.firstName,
                        score: viewModel.firstNameScore,
                        description: viewModel.getDestinyDescription(for: viewModel.firstNameScore)
                    )
                    
                    // Last Name Result
                    ResultCard(
                        title: "Last Name Analysis",
                        name: viewModel.lastName,
                        score: viewModel.lastNameScore,
                        description: viewModel.getDestinyDescription(for: viewModel.lastNameScore)
                    )
                    
                    // Total Score Result
                    ResultCard(
                        title: "Combined Destiny",
                        name: "\(viewModel.firstName) \(viewModel.lastName)",
                        score: viewModel.totalScore,
                        description: viewModel.getDestinyDescription(for: viewModel.totalScore)
                    )
                    .background(Color.blue.opacity(0.1))
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle("Destiny Results", displayMode: .inline)
        }
    }
}
