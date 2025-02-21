//
//  DestinyView.swift
//  Hohoro
//
//  Created by Warit Karnbunjob on 21/2/2568 BE.
//


import SwiftUI

private let piscesTheme = ThemeColors(
    primary: Color(hex: "#B10DC9"),    // Primary purple
    secondary: Color(hex: "#FFF0F5"),   // Light background
    text: Color.white                   // White text
)


struct DestinyView: View {
    @StateObject private var viewModel = DestinyViewModel()
    @State private var navigateToResult = false
    var body: some View {
        NavigationStack {
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
                VStack(spacing: 40) {
                    Spacer()
                    Text("Let's find your destiny")
                        .font(.custom("Avenir-Heavy", size: 28))
                        .foregroundColor(.white)
                        .padding(.top, 40)
                    
                    TextField("First Name", text: $viewModel.firstName)
                                          .font(.system(size: 20))
                                          .padding()
                                          .frame(height: 55)
                                          .background(Color.white)
                                          .cornerRadius(10)
                                          .padding(.horizontal, 40)
                                          .autocapitalization(.words)
                                      
                                      TextField("Last Name", text: $viewModel.lastName)
                                          .font(.system(size: 20))
                                          .padding()
                                          .frame(height: 55)
                                          .background(Color.white)
                                          .cornerRadius(10)
                                          .padding(.horizontal, 40)
                                          .autocapitalization(.words)
                    
                    Button(action: {
                        viewModel.calculateDestiny()
                    }) {
                        Text("Find My Destiny")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundColor(piscesTheme.primary)
                            .frame(width: 200, height: 50)
                            .background(piscesTheme.text)
                            .cornerRadius(25)
                            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                    }
                    .padding(.horizontal, 40)
                    .disabled(viewModel.firstName.isEmpty || viewModel.lastName.isEmpty)
                    
                    Spacer()
                }
                .disabled(viewModel.isLoading)
                
                if viewModel.isLoading {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 25) {
                        ProgressView()
                            .scaleEffect(2.0)
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        
                        Text("Predicting")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Checking your destiny...")
                            .font(.title2)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                NavigationLink(
                    destination: DestinyResultView(viewModel: viewModel),
                    isActive: $viewModel.showResult,
                    label: { EmptyView() }
                )
            }
        }
    }
}
