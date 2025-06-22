import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DashBoard(userName: "Vishal Sonar", profileImageName: nil, trips: sampleTrips).tabItem {
                Image(systemName: "airplane")
                Text("Trips")
            }
            .tag(0)
            .background(Color(hex: "#1E1E1E"))
            
            AddTravelEntry(resetTrigger: $selectedTab).tabItem {
                Image(systemName: "pencil")
                Text("Add Trip")
            }
            .tag(1)
            .background(Color(hex: "#1E1E1E"))
        }
        .toolbarBackground(MatteDarkTheme.tabBarBackground, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .accentColor(MatteDarkTheme.accent)
    }
}

#Preview {
    ContentView()
}

// Demo data
let sampleTrips: [TravelEntry] = [
    TravelEntry(id: UUID(), country: "Japan", city: "Tokyo", startDate: Date().addingTimeInterval(-86400*10), endDate: Date().addingTimeInterval(-86400*5), notes: "Cherry blossoms!"),
    TravelEntry(id: UUID(), country: "France", city: "Paris", startDate: Date().addingTimeInterval(-86400*30), endDate: Date().addingTimeInterval(-86400*25), notes: "Eiffel Tower visit."),
    TravelEntry(id: UUID(), country: "Australia", city: "Sydney", startDate: Date().addingTimeInterval(-86400*60), endDate: Date().addingTimeInterval(-86400*50), notes: "Sydney Opera House!"),
    TravelEntry(id: UUID(), country: "India", city: "Mumbai", startDate: Date().addingTimeInterval(-86500*60), endDate: Date().addingTimeInterval(-86800*50), notes: "Mumbai!")
]
