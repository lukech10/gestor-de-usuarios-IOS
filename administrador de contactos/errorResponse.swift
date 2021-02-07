import Foundation

struct ErrorResponse: Decodable, LocalizedError{
    let reason : String
    var errorDescription: String? {return reason}
}
