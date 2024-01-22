import Foundation
struct MealCategoriesResponse: Decodable{
    let categories: [MealCategory]
}

struct MealCategory: Decodable{
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String?
    let strCategoryDescription: String?
}
