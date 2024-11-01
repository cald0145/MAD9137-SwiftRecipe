//
//  SearchBar.swift
//  SwiftRecipe
//
//  Created by Jay Calderon on 2024-11-01.
//

import SwiftUI

// create d search bar for filtering

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)

            TextField("Search through your recipes!", text: $text)
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)

            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark")
                        .foregroundStyle(.red)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                }
            }
        }
        // adding frame height for sizing
        .frame(height: 40)
        // border with corner radius
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1.5)
        )
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}
