import Combine
import Foundation
import FirebaseFirestore

@MainActor
class FirestoreService: ObservableObject {
    @Published var journeys: [TravelEntry] = []
    private let db = Firestore.firestore()
    
    func saveJourney(country: String, city: String, startDate: Date, endDate: Date, note: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let journeyData: [String: Any] = [
            Constants.COUNTRY_KEY: country,
            Constants.CITY_KEY: city,
            Constants.START_DATE_KEY: Timestamp(date: startDate),
            Constants.END_DATE_KEY: Timestamp(date: endDate),
            Constants.NOTES_KEY: note,
            Constants.TIMESTAMP_KEY: Timestamp(date: Date())
        ]
        
        let docRef = db.collection(Constants.NODE_NAME).addDocument(data: journeyData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
        let id = docRef.documentID
        db.collection(Constants.NODE_NAME).document(id).updateData([
            Constants.ID: id,
            Constants.COUNTRY_KEY: country,
            Constants.CITY_KEY: city,
            Constants.START_DATE_KEY: Timestamp(date: startDate),
            Constants.END_DATE_KEY: Timestamp(date: endDate),
            Constants.NOTES_KEY: note,
            Constants.TIMESTAMP_KEY: Timestamp(date: Date())
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchJourneys() async {
        do {
            let snapshot = try await db.collection(Constants.NODE_NAME)
                .order(by: Constants.START_DATE_KEY, descending: false)
                .getDocuments()
            
            self.journeys = snapshot.documents.compactMap {
                try? $0.data(as: TravelEntry.self)
            }
        } catch {
            print("Error fetching journeys: \(error)")
        }
    }
    
    func deleteJourneys(trip: TravelEntry, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection(Constants.NODE_NAME).document("\(trip.id ?? "")").delete() { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
