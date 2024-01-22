import Foundation
import Combine

class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    @Published var isLoading = false
    @Published var error: Error?

    private var networkService = NetworkService()

    func fetchMealDetail(forMealId idMeal: String) {
        isLoading = true
        networkService.fetchMealDetails(forMealId: idMeal) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.mealDetail = response.meals.first
                    print("Fetched meal detail: \(String(describing: self?.mealDetail))")
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
}



