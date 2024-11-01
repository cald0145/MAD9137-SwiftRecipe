//
//  RecipeViewModel.swift
//  SwiftRecipe
//
//  Created by Jay Calderon on 2024-10-23.
//

import Foundation

// managing data for app
class RecipeViewModel: ObservableObject {
    // published property wrapper automatically updates the ui when the recipes array changes
    // array stores all recipes in the app
    @Published var recipes: [Recipe] = []
    // property for search text
    @Published var searchText: String = ""

    // :^)

    // computed property returns filtered recipes
    // auto update when searchtext or recipes change
    var filteredRecipes: [Recipe] {
        guard !searchText.isEmpty else {
            return recipes // return all recipes if no search text!!
        }

        return recipes.filter { recipe in
            // checking if search text matches title or description and if any ingredient contains the search text
            recipe.title.localizedCaseInsensitiveContains(searchText) ||
                recipe.description.localizedCaseInsensitiveContains(searchText) ||
                recipe.ingredients.contains(where: {
                    $0.localizedCaseInsensitiveContains(searchText)
                })
        }
    }

    // WIP, adds new recipe parameter
    func addRecipe(_ recipe: Recipe) {
        recipes.append(recipe)
    }

    // removes recipe at specific indices from array, used for swipe delete
    // offsets are indices for recipes to be deleted!
    func deleteRecipe(at offsets: IndexSet) {
        recipes.remove(atOffsets: offsets)
    }

    func updateRecipe(_ updatedRecipe: Recipe) {
        // finding index of the recipe with matching id
        if let index = recipes.firstIndex(where: { $0.id == updatedRecipe.id }) {
            print("updating recipe index: \(index)")
            print("old recipe: \(recipes[index])")
            print("new recipe: \(updatedRecipe)")
            // replacing old recipe with updated one
            recipes[index] = updatedRecipe
        }
    }
}
