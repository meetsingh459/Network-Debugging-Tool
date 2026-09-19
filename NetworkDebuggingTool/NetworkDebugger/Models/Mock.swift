
import Foundation

struct Mock: Identifiable, Codable {
    let id: UUID
    var urlPattern: String
    var httpMethod: String
    var jsonFileName: String
    var statusCode: Int
    var isEnabled: Bool

    init(id: UUID = UUID(),
         urlPattern: String,
         httpMethod: String? = nil,
         jsonFileName: String,
         statusCode: Int = 200,
         isEnabled: Bool = false) {
        self.id = id
        self.urlPattern = urlPattern
        self.httpMethod = httpMethod ?? "GET"
        self.jsonFileName = jsonFileName
        self.statusCode = statusCode
        self.isEnabled = isEnabled
    }
}
