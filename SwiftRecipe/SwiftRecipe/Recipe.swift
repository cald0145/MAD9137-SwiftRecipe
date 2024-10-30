//
//  Recipe.swift
//  SwiftRecipe
//
//  Created by Jay Calderon on 2024-10-23.
//

import Foundation

struct Recipe: Identifiable {
    // all properties for each recipe
    var id = UUID()
    var title: String
    var description: String
    var ingredients: [String]
    var steps: [String]
    var date: Date

    // default initializer that creates a new UUID
    init(title: String, description: String, ingredients: [String], steps: [String], date: Date) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.ingredients = ingredients
        self.steps = steps
        self.date = date
    }

    // special initializer for updating existing recipes that takes an ID
    init(id: UUID, title: String, description: String, ingredients: [String], steps: [String], date: Date) {
        self.id = id
        self.title = title
        self.description = description
        self.ingredients = ingredients
        self.steps = steps
        self.date = date
    }

    // static method to create a recipe

    static func testRecipe() -> Recipe {
        Recipe(
            title: "Classic Grilled Cheese",
            description: "A grilled cheese sandwich is a crispy, golden-brown bread filled with melted, gooey cheese.",
            ingredients: [
                "2 Slices of bread",
                "2 Slices of American cheese",
                "1-2 tbsp of butter",
            ],
            steps: [
                "Butter one side of each bread slice.",
                "Place one slice, butter-side down, on a pan over medium heat.",
                "Add cheese slices on top of the bread.",
                "Place the second slice on top, butter-side up.",
                "Cook for 2-3 minutes until golden brown.",
                "Flip and cook the other side for another 2-3 mionutes.",
                "Remove from heat, slice, and serve warm.",
            ],
            date: Date()
        )
    }
}
