import SwiftUI
import Foundation
import FirebaseFirestore

@MainActor
struct TravelEntry: Identifiable, Codable {
    @DocumentID var id: String?
    var country: String
    var city: String
    var startDate: Date
    var endDate: Date
    var notes: String
    var timestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case country
        case city
        case startDate
        case endDate
        case notes
        case timestamp
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? Constants.UNKNOWN_COUNTRY
        self.city = try container.decodeIfPresent(String.self, forKey: .city) ?? Constants.UNKNOWN_CITY
        self.notes = try container.decodeIfPresent(String.self, forKey: .notes) ?? Constants.EMPTY
        
        if let startTimestamp = try container.decodeIfPresent(Timestamp.self, forKey: .startDate) {
            self.startDate = startTimestamp.dateValue()
        } else {
            self.startDate = Date()
        }
        
        if let endTimestamp = try container.decodeIfPresent(Timestamp.self, forKey: .endDate) {
            self.endDate = endTimestamp.dateValue()
        } else {
            self.endDate = Date()
        }
        
        if let ts = try container.decodeIfPresent(Timestamp.self, forKey: .timestamp) {
            self.timestamp = ts.dateValue()
        } else {
            self.timestamp = Date()
        }
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
    }
}
