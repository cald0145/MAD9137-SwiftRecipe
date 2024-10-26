//
//  AddRecipeView.swift
//  SwiftRecipe
//
//  Created by Jay Calderon on 2024-10-25.
//
import SwiftUI

// form interface with fields
struct AddRecipeView: View {
    // env var to dimiss view
    @Environment(\.dismiss) var dismiss
    // observed object since changing the recipes,
    @ObservedObject var viewModel: RecipeViewModel

    // variables to store input for new recipe, adding temp vars
    @State private var title = ""
    @State private var description = ""
    @State private var currentIngredient = ""
    @State private var currentStep = ""
    @State private var ingredients: [String] = []
    @State private var steps: [String] = []
    
    // var for alert
    @State private var showingValidationAlert = false
    @State private var validationMessage = ""
    
    var body: some View {
        // nav bar with the save cancel btns
        NavigationView {
            Form {
                // form is scrollable and sections everything
                Section(header: Text("Recipe Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }

                Section(header: Text("Ingredients")) {
                    HStack {
                        TextField("Add Ingredients (e.g. 1 cup of flour...)", text: $currentIngredient)
                        Button(action: addIngredient) {
                            Image(systemName: "plus.circle.fill")
                        }
                        // btn disabled if field is empty
                        .disabled(currentIngredient.isEmpty)
                    }
                    
                    // list of added ingredients with delete ability
                    ForEach(ingredients, id: \.self) { ingredient in
                        Text(ingredient)
                    }
                    .onDelete(perform: deleteIngredient)
                }
                
                Section(header: Text("Steps")) {
                    // same layout as ingredients
                    HStack {
                        TextField("Add Step (e.g. mix everything...)", text: $currentStep)

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
            .navigationTitle("Add Recipe")
            .toolbar {
                // cancel button closes the form without saving
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                // save btn!!!
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveRecipe()
                    }
                    // no save if the fields are empty
                    .disabled(!isValidRecipe)
                }
            }
            // alert
            .alert("Cannot Save Recipe", isPresented: $showingValidationAlert) {
                Button("Ok", role: .cancel) {}
            } message: {
                Text(validationMessage)
            }
        }
    }
    
    // computed property to check if the recipe has all required fields
    private var isValidRecipe: Bool {
        !title.isEmpty && !ingredients.isEmpty && !steps.isEmpty
    }
    
    // adding the current ingredient to the ingredients array
    private func addIngredient() {
        // trimming whitespace and checking if ingredient is not empty
        let trimmedIngredient = currentIngredient.trimmingCharacters(in: .whitespaces)
        guard !trimmedIngredient.isEmpty else { return }
        // add ingredient and clear field
        ingredients.append(trimmedIngredient)
        currentIngredient = ""
    }
    
    // adding steps, same as ingredients
    private func addStep() {
        let trimmedStep = currentStep.trimmingCharacters(in: .whitespaces)
        guard !trimmedStep.isEmpty else { return }
        steps.append(trimmedStep)
        currentStep = ""
    }
    
    // removing ingredients at specified indices
    private func deleteIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }

    // removes steps
    private func deleteStep(at offsets: IndexSet) {
        steps.remove(atOffsets: offsets)
    }
    
    // save the recipe and dismiss the view
    private func saveRecipe() {
        // validate all required fields
        
        //check!!!! WIP
        guard !title.isEmpty else {
            validationMessage = "Please enter a title!"
            showingValidationAlert = true
            return
        }
        
        guard !ingredients.isEmpty else {
            validationMessage = "Please add at least one ingredient!"
            showingValidationAlert = true
            return
        }
        
        guard !steps.isEmpty else {
            validationMessage = "Please add at least one step!"
            showingValidationAlert = true
            return
        }
        
        // create and add the new recipe
        let recipe = Recipe(
            title: title,
            description: description,
            ingredients: ingredients,
            steps: steps,
            date: Date()
        )
        
        // add to view model and dismiss the sheet
        viewModel.addRecipe(recipe)
        dismiss()
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(viewModel: RecipeViewModel())
    }
}
