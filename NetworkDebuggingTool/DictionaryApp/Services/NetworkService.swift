

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case dataNotFound
    case decodingFailed
}

import Foundation

class NetworkService {
    
    private let baseURL = "https://api.dictionaryapi.dev/api/v2/entries/en/"

    func fetchData(for word: String) async throws -> [WordEntryModel] {
        guard let url = URL(string: "\(baseURL)\(word)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.dataNotFound
        }
        
        do {
            return try JSONDecoder().decode([WordEntryModel].self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
