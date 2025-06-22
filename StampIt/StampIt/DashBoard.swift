import SwiftUI

struct DashBoard: View {
    let userName: String
    let profileImageName: String?
    let trips: [TravelEntry]

    var body: some View {
        VStack {
            VStack {
                WelcomeCard(userName: userName, profileImageName: profileImageName)
                HStack {
                    StatCard(title: Constants.COUNTRIES, value: "\(uniqueCountries(trips))", iconName: Constants.ICON_GLOBE)
                }
                HStack {
                    StatCard(title: Constants.TRIPS, value: "\(trips.count)", iconName: Constants.ICON_AIRPLANE)
                    StatCard(title: Constants.DAYS, value: "\(totalDays(trips))", iconName: Constants.ICON_CALENDAR)
                }
            }
            .padding()
            HStack {
                Text(Constants.RECENT_JOURNEYS).font(.title).bold()
                                               .foregroundColor(MatteDarkTheme.textPrimary)
                                               .padding()
                Spacer()
            }
            if trips.isEmpty {
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
                        ForEach(trips) { trip in
                            JourneyCard(trip: trip)
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
