import Foundation
import SwiftUI

struct DictionaryView: View {
    @StateObject private var viewModel = DictionaryViewViewModel()
    
    var body: some View {
        VStack {
            Text("Dictionary")
                .font(.title)
                .bold()
            
            SearchBar(query:$viewModel.query, searchReult: viewModel.searchReult)

            switch viewModel.viewState {
            case .idle:
                EmptyView()
            case .loading:
                Text("Loading...").font(.subheadline).bold()
            case .success(let data):
                DetailsView(data: data, playAudio: viewModel.playPronunciation)
            case .failure(let error):
                Text(error.localizedDescription).font(.subheadline).bold()
            }
            
            Spacer()
        }
    }
}

#Preview {
    
    DictionaryView()
}
