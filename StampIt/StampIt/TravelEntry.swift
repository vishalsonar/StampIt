import SwiftUI

struct TravelEntry: Identifiable, Codable {
    let id: UUID
    var country: String
    var city: String
    var startDate: Date
    var endDate: Date
    var notes: String
}
