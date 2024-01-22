import Foundation

struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}

struct MealDetail: Decodable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String?
    let strMealThumb: String?
    var ingredients: [Ingredient]

    struct Ingredient {
        let name: String
        let measure: String
    }

    private struct AnyCodingKey: CodingKey {
        var stringValue: String
        var intValue: Int?

        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }

        init?(intValue: Int) {
            self.stringValue = String(intValue)
            self.intValue = intValue
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AnyCodingKey.self)
        
        idMeal = try container.decode(String.self, forKey: AnyCodingKey(stringValue: "idMeal")!)
        strMeal = try container.decode(String.self, forKey: AnyCodingKey(stringValue: "strMeal")!)
        strInstructions = try container.decodeIfPresent(String.self, forKey: AnyCodingKey(stringValue: "strInstructions")!)
        strMealThumb = try container.decodeIfPresent(String.self, forKey: AnyCodingKey(stringValue: "strMealThumb")!)

        var ingredientsArray: [Ingredient] = []
        for i in 1...20 {
            let ingredientKeyName = "strIngredient\(i)"
            let measureKeyName = "strMeasure\(i)"
            
            
            if let ingredient = try container.decodeIfPresent(String.self, forKey: AnyCodingKey(stringValue: ingredientKeyName)!),
               let measure = try container.decodeIfPresent(String.self, forKey: AnyCodingKey(stringValue: measureKeyName)!),
               !ingredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                ingredientsArray.append(Ingredient(name: ingredient, measure: measure))
            }
        }

        self.ingredients = ingredientsArray
    }

    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb
    }
}
