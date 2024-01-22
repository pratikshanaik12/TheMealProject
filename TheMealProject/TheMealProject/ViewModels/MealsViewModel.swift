import Foundation
import Combine

class MealsViewModel: ObservableObject {
    @Published var meals = [Meal]()
    @Published var isLoading = false
    @Published var error: Error?

    private var networkService = NetworkService()

    func fetchMeals(forCategory category: String) {
        isLoading = true
        networkService.fetchMeals(forCategory: category) { [weak self] (result: Result<MealResponse, NetworkError>) in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.meals = response.meals.sorted {$0.strMeal < $1.strMeal}
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
}

