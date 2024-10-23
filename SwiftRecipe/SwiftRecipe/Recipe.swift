//
//  Recipe.swift
//  SwiftRecipe
//
//  Created by Jay Calderon on 2024-10-23.
//

import Foundation

struct Recipe: Identifiable {
    //all properties for each recipe
    let id = UUID()
    var title: String
    var description: String
    var ingredients: [String]
    var instructions: [String]
    var date: Date

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
            instructions: [
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
