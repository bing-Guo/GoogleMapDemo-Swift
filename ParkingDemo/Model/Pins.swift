import Foundation

// MARK: - PinsResult

struct PinsResult: Codable {
    let total: Int
    let result: [Pin]
}

// MARK: - Pins

struct Pin: Codable {
    let position: Position
    var title, openTime, image, comment, fee, entryMethod, phone, highlight: String
    var limit: Int
}

// MARK: - Position

struct Position: Codable {
    let lat, long: Double
}
