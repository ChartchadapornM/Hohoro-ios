//
//  SecondView.swift
//  Hohoro
//
//  Created by warit karn on 9/2/2568 BE.
//

import SwiftUI
import PhotosUI

struct SecondView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        ZStack {
            // Background
            Color.black.opacity(0.95)
                .ignoresSafeArea()
            
            VStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 300)
                        .padding()
                }
                
                Button(action: {
                    showImagePicker = true
                }) {
                    HStack {
                        Image(systemName: "photo.fill")
                            .foregroundColor(.white)
                        Text("Upload")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(width: 200)
                    .background(Color(hex: "#B10DC9"))
                    .cornerRadius(12)
                }
            }
        }
        .navigationBarTitle("Select Photo", displayMode: .inline)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
}


