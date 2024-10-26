//
//  RecipeDetailView.swift
//  SwiftRecipe
//
//  Created by Jay Calderon on 2024-10-23.
//

import SwiftUI

// details of recipe on this screen, delete ability
struct RecipeDetailView: View {
    // storing recipe for display
    let recipe: Recipe
    // watching for changes and update with view model and observed object
    @ObservedObject var viewModel: RecipeViewModel
    // state var for delete confirm alert visibility,
    @State private var showingDeleteAlert = false

    var body: some View {
        // scrollview extends scroll past screen size
        ScrollView {
            // start everything on left with leading alignment!! seperate sections
            VStack(alignment: .leading, spacing: 20) {
                Text(recipe.title)
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 5)
                // description section, using light grey text
                Text(recipe.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 10)
                // ingredients section, using vertical stack for header and list
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ingredients")
                        .font(.title2)
                        .bold()
                    // iterating through ingredients array and adding bullet point for each
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        Text("• \(ingredient)")
                            .padding(.leading)
                    }
                }
                .padding(.bottom, 10)
                // steps section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Steps")
                        .font(.title2)
                        .bold()
                    // iterate through instructions array with index, enumerated() gives both the index and instruction
                    // index + 1 used to start numbering from 1 instead of 0!!
                    ForEach(Array(recipe.steps.enumerated()), id: \.element) { index, step in
                        Text("\(index + 1). \(step)")
                            .padding(.leading)
                    }
                }
                // date section, shows under recipe in tiny grey text
                Text("Date added: \(recipe.date.formatted(date: .abbreviated, time: .shortened))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .toolbar {
            // adding the delete btn to the nav bar using toolbar
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // tapping trash button triggers the confirm modal
                    showingDeleteAlert = true
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
        }

        // modal when showdelete alert is true, button is destructive red
        // finding the recipe in the view models array
        .alert("Want to delete this recipe?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                if let index = viewModel.recipes.firstIndex(where: { $0.id == recipe.id }) {
                    viewModel.recipes.remove(at: index)
                }
            }
            // cancel button
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This cannot be undone!")
        }
    }
}

// warpping the view in the nav view to see
struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipeDetailView(
                recipe: Recipe.testRecipe(),
                viewModel: RecipeViewModel()
            )
        }
    }
}
