//
//  ResultCard.swift
//  Hohoro
//
//  Created by Warit Karnbunjob on 21/2/2568 BE.
//
import SwiftUI
import Foundation

struct ResultCard: View {
    let title: String
    let name: String
    let score: Int
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(.blue)
            
            Text(name)
                .font(.title3)
                .fontWeight(.medium)
            
            Text("Score: \(score)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(description)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(12)
    }
}
