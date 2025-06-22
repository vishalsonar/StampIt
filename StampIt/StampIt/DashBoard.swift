import SwiftUI

struct DashBoard: View {
    let userName: String
    let profileImageName: String?
    @ObservedObject var firestore: FirestoreService

    var body: some View {
        VStack {
            VStack {
                WelcomeCard(userName: userName, profileImageName: profileImageName)
                HStack {
                    StatCard(title: Constants.COUNTRIES, value: "\(uniqueCountries(firestore.journeys))", iconName: Constants.ICON_GLOBE)
                }
                HStack {
                    StatCard(title: Constants.TRIPS, value: "\(firestore.journeys.count)", iconName: Constants.ICON_AIRPLANE)
                    StatCard(title: Constants.DAYS, value: "\(totalDays(firestore.journeys))", iconName: Constants.ICON_CALENDAR)
                }
            }
            .padding()
            HStack {
                Text(Constants.RECENT_JOURNEY).font(.title2).bold()
                                              .foregroundColor(MatteDarkTheme.textPrimary)
                                              .padding()
                Spacer()
            }
            if firestore.journeys.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: Constants.ICON_AIRPLANE).font(.system(size: 48))
                                                              .foregroundColor(MatteDarkTheme.textSecondary.opacity(0.7))
                    Text(Constants.NO_RECENT_TRIPS).font(.title3.weight(.medium))
                                                   .foregroundColor(MatteDarkTheme.textSecondary)
                    Text(Constants.NO_RECENT_TRIPS_MESSAGE).font(.subheadline)
                                                           .foregroundColor(MatteDarkTheme.textSecondary.opacity(0.8))
                                                           .multilineTextAlignment(.center)
                                                           .padding(.horizontal, 40)
                }
                .frame(maxHeight: .infinity, alignment: .center)
            } else {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(firestore.journeys.prefix(1)) { trip in
                            RecentJourneyCard(trip: trip)
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .padding(.vertical)
    }
    
    func uniqueCountries(_ trips: [TravelEntry]) -> Int {
        Set(trips.map { $0.country }).count
    }
    
    func totalDays(_ trips: [TravelEntry]) -> Int {
        trips.reduce(0) { sum, trip in
            sum + Calendar.current.dateComponents([.day], from: trip.startDate, to: trip.endDate).day!
        }
    }
}
