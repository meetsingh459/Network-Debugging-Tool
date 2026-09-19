
import SwiftUI

struct DetailsView: View {
    
    let data: WordEntryModel
    var playAudio: (String) -> Void
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let audioURL = data.audioURL {
                    Button {
                        playAudio(audioURL)
                    } label: {
                        Image(systemName: "speaker.wave.2.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.blue)
                    }
                    
                    Text(data.word)
                        .font(.title2)
                        .bold()
                } else {
                    Text("Word: \(data.word)")
                        .font(.title2)
                        .bold()
                }
            }
            .padding(15)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if let origin = data.origin {
                Text("Origin: \(origin)")
            }
            
            List(data.meanings) { meaning in
                VStack(alignment: .leading) {
                    Text(meaning.partOfSpeech)
                        .font(.title)
                        .bold()
                    
                    if let definition = meaning.definitions.first {
                        Text(definition.definition)
                            .font(.headline)
                        Text(definition.example ?? "No example is available.")
                            .font(.footnote)
                    }
                }
            }
            .listStyle(.inset)
        }
    }
}

