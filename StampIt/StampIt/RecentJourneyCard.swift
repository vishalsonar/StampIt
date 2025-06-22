import SwiftUI

struct RecentJourneyCard: View {
    var trip: TravelEntry
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).fill(MatteDarkTheme.cardBackground)
                                              .frame(height: 160)
                                              .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(trip.country.uppercased()).font(.title2)
                                                   .fontWeight(.bold)
                                                   .foregroundColor(.white)
                    Spacer()
                    Image(systemName: Constants.ICON_AIRPLANE).font(.title2)
                                                              .foregroundColor(.white.opacity(0.9))
                }
                HStack {
                    let travelDates = (trip.startDate.formatted(date: .abbreviated, time: .omitted))
                                      + Constants.ARROW
                                      + (trip.endDate.formatted(date: .abbreviated, time: .omitted));
                    Text(trip.city.uppercased()).font(.subheadline)
                                                .foregroundColor(.white.opacity(0.9))
                    Spacer()
                    Text(travelDates).font(.subheadline)
                                     .foregroundColor(.white.opacity(0.9))
                }
                Text(trip.notes).font(.caption)
                                .foregroundColor(.white.opacity(0.8))
            }
            .padding()
        }
        .padding(.horizontal)
    }
}
