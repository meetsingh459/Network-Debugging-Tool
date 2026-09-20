
import Foundation

struct WordEntryModel: Decodable {
    let word: String
    let phonetics: [Phonetic]
    let origin: String?
    let meanings: [Meaning]
    
    
    var audioURL: String? {
        phonetics.first { $0.audio != nil }?.audio
    }
    
    var pronunciation: String? {
        phonetics.first?.text
    }
}

struct Phonetic: Decodable {
    let text: String?
    let audio: String?
}

struct Meaning: Decodable, Identifiable {
    let id: String = UUID().uuidString
    let partOfSpeech: String
    let definitions: [Definition]
}

struct Definition: Decodable {
    var id: String {
        return "definition\(UUID().uuidString)"
    }
    
    let definition: String
    let example: String?
}


