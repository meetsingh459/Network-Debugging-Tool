
import Foundation
import Combine

enum ViewState {
    case idle
    case loading
    case success(WordEntryModel)
    case failure(Error)
}

@MainActor
class DictionaryViewViewModel: ObservableObject {
    
    @Published var query = ""
    @Published private(set) var viewState: ViewState = .idle
    
    private let networkService = NetworkService()
    private let audioService = AudioService()
    
    func searchReult() async {
        guard !query.isEmpty else {
            viewState = .idle
            return
        }
        
        viewState = .loading
        // Fetch Data
        do {
            let data = try await networkService.fetchData(for: query)
            
            guard let fetchedData = data.first else {
                viewState = .failure(NetworkError.dataNotFound)
                return
            }
            
            viewState = .success(fetchedData)
        } catch {
            viewState = .failure(error)
        }
        
    }
    
    func playPronunciation(_ url: String) {
        audioService.play(for: url)
    }
}
