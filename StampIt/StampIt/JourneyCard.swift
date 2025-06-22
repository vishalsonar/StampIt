import SwiftUI

struct JourneyCard: View {
    var trip: TravelEntry
    var tripView: SelectTripView
    
    @State private var showDeleteConfirm = false
    @State private var isDeleting = false
    
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
                Spacer()
                Divider().frame(height: 2).overlay(MatteDarkTheme.accent)
                HStack() {
                    Button(action: {showDeleteConfirm = true}) {
                        Text(Constants.DELETE).fontWeight(.bold)
                                              .foregroundColor(.white)
                                              .frame(maxWidth: .infinity)
                                              .font(.caption)
                                              .cornerRadius(12)
                    }
                    .confirmationDialog(Constants.DELETE_CONFIRM_MESSAGE, isPresented: $showDeleteConfirm, titleVisibility: .visible) {
                        Button(Constants.DELETE, role: .destructive) {
                            Task {
                                await tripView.deleteSelectedTrip(trip: trip)
                            }
                        }
                    }
                    
                    
                
//                    Divider().frame(width: 2).overlay(MatteDarkTheme.accent)
//                    Button(action: {
//                        Task {
//                            await tripView.deleteSelectedTrip(trip: trip)
//                        }
//                    }) {
//                        Text(Constants.UPDATE).fontWeight(.bold)
//                                              .foregroundColor(.white)
//                                              .frame(maxWidth: .infinity)
//                                              .font(.caption)
//                                              .cornerRadius(12)
//                    }
                }
            }
            .padding()
        }
        .padding(.horizontal)
    }
}
