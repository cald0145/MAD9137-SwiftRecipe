//
//  EditRecipeView.swift
//  SwiftRecipe
//
//  Created by Jay Calderon on 2024-10-29.
//

import SwiftUI

// view with a form interface to edit exisitng recipe
// pre filled recipe data
struct EditRecipeView: View {
    // enviro variable to dismiss view when done
    @Environment(\.dismiss) var dismiss
    
    // reference to view model for updating recipe
    @ObservedObject var viewModel: RecipeViewModel
    
    // store original recipe for ref
    let recipe: Recipe
    
    // remmeber: state var hold the edited recipe
    // init with existing recipe data
    @State private var title: String
    @State private var description: String
    @State private var currentIngredient = ""
    @State private var currentStep = ""
    @State private var ingredients: [String]
    @State private var steps: [String]
    
    // initialing state variables with existing recipe data
    init(recipe: Recipe, viewModel: RecipeViewModel) {
        self.recipe = recipe
        self.viewModel = viewModel
        
        // initialize state properties with recipe values
        _title = State(initialValue: recipe.title)
        _description = State(initialValue: recipe.description)
        _ingredients = State(initialValue: recipe.ingredients)
        _steps = State(initialValue: recipe.steps)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // recipe details section
                Section(header: Text("Recipe Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
                
                // ingredients section
                Section(header: Text("Ingredients")) {
                    HStack {
                        TextField("Add Ingredient", text: $currentIngredient)
                        
                        Button(action: addIngredient) {
                            Image(systemName: "plus.circle.fill")
                        }
                        .disabled(currentIngredient.isEmpty)
                    }
                    
                    ForEach(ingredients, id: \.self) { ingredient in
                        Text(ingredient)
                    }
                    .onDelete(perform: deleteIngredient)
                }
                
                // steps section
                Section(header: Text("Steps")) {
                    HStack {
                        TextField("Add Step", text: $currentStep)
                        
                        Button(action: addStep) {
                            Image(systemName: "plus.circle.fill")
                        }
                        .disabled(currentStep.isEmpty)
                    }
                    
                    ForEach(steps, id: \.self) { step in
                        Text(step)
                    }
                    .onDelete(perform: deleteStep)
                }
            }
            .navigationTitle("Edit Recipe")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveRecipe()
                    }
                    .disabled(!isValidRecipe)
                }
            }
        }
    }
    
    // NOTE: computed property to check if the recipe has all required fields
    private var isValidRecipe: Bool {
        !title.isEmpty && !ingredients.isEmpty && !steps.isEmpty
    }
    
    // new ingredient to the list
    private func addIngredient() {
        let trimmedIngredient = currentIngredient.trimmingCharacters(in: .whitespaces)
        guard !trimmedIngredient.isEmpty else { return }
        
        ingredients.append(trimmedIngredient)
        currentIngredient = ""
    }
    
    // add new step to list
    private func addStep() {
        let trimmedStep = currentStep.trimmingCharacters(in: .whitespaces)
        guard !trimmedStep.isEmpty else { return }
        
        steps.append(trimmedStep)
        currentStep = ""
    }
    
    // remove ingredients
    private func deleteIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
    
    // remove steps
    private func deleteStep(at offsets: IndexSet) {
        steps.remove(atOffsets: offsets)
    }
    
    // save the edited recipe
    private func saveRecipe() {
        print("saving recipe")
        print("original id: \(recipe.id)")
        // creating updated recipe with new data
        let updatedRecipe = Recipe(
            id: recipe.id,
            title: title,
            description: description,
            ingredients: ingredients,
            steps: steps,
            date: recipe.date
        )
        print("new recipe id: \(updatedRecipe.id)")
        // update recipe in the view model
        viewModel.updateRecipe(updatedRecipe)
        dismiss()
    }
}
