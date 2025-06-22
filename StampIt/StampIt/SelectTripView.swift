import SwiftUI

struct SelectTripView: View {
    @State private var year: String = "\(Calendar.current.component(.year, from: Date()))"
    @State private var isLoading: Bool = false
    @State private var filteredTrips: [TravelEntry] = []
    
    @ObservedObject var firestore: FirestoreService
    @StateObject private var toastManager = ToastManager()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(Constants.YOUR_JOURNEY_BY_YEAR).font(.title2.bold()).foregroundColor(MatteDarkTheme.textPrimary).padding().padding(.top)
            YearPickerView(selectedYear: $year, startYear: 1900, endYear: Calendar.current.component(.year, from: Date())).disabled(isLoading)
            HStack {
                Spacer()
                Button(action: fetchTripsForSelectedYear) {
                    HStack {
                        if isLoading {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }
                        Image(systemName: Constants.SQUARE_AND_ARROW_DOWN)
                        Text(Constants.VIEW + " \(year) ").fontWeight(.semibold)
                    }
                    .foregroundColor(MatteDarkTheme.primaryBackground)
                    .padding()
                    .background(MatteDarkTheme.accent)
                    .cornerRadius(12)
                    .shadow(radius: 6)
                }
                .disabled(isLoading)
                Spacer()
            }
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(filteredTrips) { trip in
                        JourneyCard(trip: trip, tripView: self)
                    }
                }
                .padding(.vertical)
            }
            HStack {
                Spacer()
                ToastMessage(toastManager: toastManager)
                Spacer()
            }
        }
    }
    
    func deleteSelectedTrip(trip: TravelEntry) async {
        if let index = filteredTrips.firstIndex(where: { $0.id == trip.id }) {
            firestore.deleteJourneys(trip: trip) { result in
                switch result {
                case .success:
                    filteredTrips.remove(at: index)
                    toastManager.show(Constants.TRIP_DELETED_SUCCESSFULLY)
                case .failure(let _error):
                    toastManager.show(Constants.ERROR_DELETING_TRIP)
                }
            }
        }
        await firestore.fetchJourneys()
    }
    
    func fetchTripsForSelectedYear() {
        isLoading = true
        if firestore.journeys.isEmpty {
            toastManager.show(Constants.NO_JOURNEY_FOUND_ERROR_MESSAGE)
            isLoading = false
            return
        }
        filteredTrips = firestore.journeys.filter { entry in
            let entryYear = Calendar.current.component(.year, from: entry.startDate)
            return entryYear == Int(year)
        }
        if filteredTrips.isEmpty {
            toastManager.show(Constants.NO_JOURNEY_FOUND_ERROR_MESSAGE)
            isLoading = false
            return
        }
        isLoading = false
    }
}

struct YearPickerView: View {
    @Binding var selectedYear: String
    let startYear: Int
    let endYear: Int
    
    var body: some View {
        let years: [String] = (startYear...endYear).reversed().map { "\($0)" }
        Picker(Constants.SELECT_YEAR, selection: $selectedYear) {
            ForEach(years, id: \.self) { year in
                Text(year).tag(year)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(height: UIScreen.main.bounds.height * 0.15)
        .padding(5)
    }
}
