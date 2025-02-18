//
//  Physiognomy.swift
//  Hohoro
//
//  Created by warit karn on 9/2/2568 BE.
//

import SwiftUI

struct PhysiognomyPoint: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color(hex: "#B10DC9"))
            
            Text(description)
                .foregroundColor(.white.opacity(0.9))
        }
        .padding(.vertical, 4)
    }
}
