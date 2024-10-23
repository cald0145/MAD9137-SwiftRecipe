//
//  ContentView.swift
//  SwiftRecipe
//
//  Created by Jay Calderon on 2024-10-23.
//

import SwiftUI

struct ContentView: View {
    // remember: stateobject creates lifecycle of the view model, will refresh for changes
    @StateObject private var viewModel = RecipeViewModel()

    var body: some View {
        // navigation bar
        NavigationView {
            // scroll list with for each to iterate over all recipes,
            List {
                ForEach(viewModel.recipes) { recipe in
                    // vertical stack with leading alignment
                    VStack(alignment: .leading) {
                        Text(recipe.title)
                            .font(.headline)
                        // recipe description in subheadline
                        Text(recipe.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .onDelete(perform: viewModel.deleteRecipe)
                // swipe delete function, call delete recipe when swipe
            }
            .navigationTitle("SwiftRecipe")
            .toolbar {
                // adding a add button to trailing side of nav bar
                ToolbarItem(placement: .navigationBarTrailing) {
                    // add recipe button function,

                    // add recipe screen later!!!!! WIP
                    Button(action: {
                        viewModel.addRecipe(Recipe.testRecipe())
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

// using preview provider to see in canvas??
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
