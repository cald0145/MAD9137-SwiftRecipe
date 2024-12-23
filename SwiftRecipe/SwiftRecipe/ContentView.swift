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

    // state variable for the display of the add recipe sheet
    @State private var showingAddRecipe = false

    var body: some View {
        // navigation bar
        NavigationStack {
            // scroll list with for each to iterate over all recipes,
            // zstack for message behind list layer
            ZStack {
                // message when no recipes!
                if viewModel.recipes.isEmpty || (!viewModel.searchText.isEmpty && viewModel.filteredRecipes.isEmpty) {
                    // vertical arrange text
                    VStack(spacing: 10) {
                        Image(systemName: "fork.knife.circle.fill")
                            .font(.system(size: 70))
                            .foregroundStyle(.gray)
                            .symbolRenderingMode(.hierarchical) // depth?
                        // messages bases on search results
                        if viewModel.recipes.isEmpty {
                            Text("No Recipes Yet.. :^(")
                                .font(.headline)
                                .foregroundColor(.gray)

                            Text("Add a new recipe to get started!")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        } else {
                            Text("No matching recipes!")
                                .font(.headline)
                                .foregroundColor(.gray)

                            Text("Try a different search term!")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    // center stack
                    .padding()
                }

                VStack {
                    // search bar at top of list
                    SearchBar(text: $viewModel.searchText)
                        .padding(.bottom, 8)

                    // list on top and empty when not populated
                    // using filtered recipes for list
                    List {
                        ForEach(viewModel.filteredRecipes) { recipe in
                            // recipes in nav link
                            NavigationLink(destination: RecipeDetailView(recipe: recipe, viewModel: viewModel)) {
                                // vertical stack with leading alignment
                                VStack(alignment: .leading) {
                                    Text(recipe.title)
                                        .font(.headline)
                                    // recipe description in subheadline
                                    Text(recipe.description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding(.vertical, 8)
                            }
                        }
                        .onDelete(perform: viewModel.deleteRecipe)
                        // swipe delete function, call delete recipe when swipe
                    }
                    .listStyle(PlainListStyle())
                }
            }

            .navigationTitle("SwiftRecipe")
            .toolbar {
                // adding a add button to trailing side of nav bar
                ToolbarItem(placement: .navigationBarTrailing) {
                    // add recipe button function
                    Button(action: {
                        // change to toggle
                        showingAddRecipe.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            // showing the add recipe view as a sheet when showingAddRecipe is true
            .sheet(isPresented: $showingAddRecipe) {
                AddRecipeView(viewModel: viewModel)
            }
        }
    }
}

// using preview provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
