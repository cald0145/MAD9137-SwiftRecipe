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

    // init sets up state of the view model
    // adding test recipe grilled cheese :^)
    init() {
        recipes.append(Recipe.testRecipe())
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
}
