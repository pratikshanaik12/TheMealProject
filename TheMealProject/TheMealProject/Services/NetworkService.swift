import Foundation

struct NetworkService {
    private let baseUrl = "https://www.themealdb.com/api/json/v1/1"
    
    func fetchMealCategories(completion: @escaping (Result<MealCategoriesResponse, NetworkError>) -> Void) {
        let url = "\(baseUrl)/categories.php"
        fetch(urlString: url, completion: completion)
    }

    func fetchMeals(forCategory category: String, completion: @escaping (Result<MealResponse, NetworkError>) -> Void) {
        guard let encodedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(.invalidURL))
            return
        }

        let url = "\(baseUrl)/filter.php?c=\(encodedCategory)"
        fetch(urlString: url, completion: completion)
    }

    func fetchMealDetails(forMealId idMeal: String, completion: @escaping (Result<MealDetailResponse, NetworkError>) -> Void) {
        let url = "\(baseUrl)/lookup.php?i=\(idMeal)"
        fetch(urlString: url, completion: completion)
    }

    private func fetch<T: Decodable>(urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.apiError(error)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            if let json = String(data: data, encoding: .utf8) {
                       print("Raw JSON response: \(json)")
                   }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }

}






