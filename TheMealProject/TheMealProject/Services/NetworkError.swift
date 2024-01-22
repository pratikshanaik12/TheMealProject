import Foundation

enum NetworkError: Error {
    case invalidURL
    case apiError(Error)
    case noData
    case decodingError
}

