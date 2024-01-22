import Foundation
import Combine

class MealCategoriesViewModel: ObservableObject {
    @Published var categories = [MealCategory]()
    @Published var isLoading = false
    @Published var error: Error?

    private var networkService = NetworkService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchMealCategories()
    }

    func fetchMealCategories() {
        isLoading = true
        networkService.fetchMealCategories { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.categories = response.categories.sorted{$0.strCategory < $1.strCategory}
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
}
