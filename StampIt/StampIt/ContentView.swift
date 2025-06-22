import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @StateObject private var firestore = FirestoreService()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DashBoard(userName: "Vishal Sonar", profileImageName: nil, firestore: firestore).tabItem {
                Image(systemName: "airplane")
            }
            .tag(0)
            .background(MatteDarkTheme.primaryBackground)
            .task {
                await firestore.fetchJourneys()
            }
            
            SelectTripView(firestore: firestore).tabItem {
                Image(systemName: "filemenu.and.selection")
            }
            .tag(1)
            .background(MatteDarkTheme.primaryBackground)
            .task {
                await firestore.fetchJourneys()
            }
            
            AddTravelEntry(resetTrigger: $selectedTab).tabItem {
                Image(systemName: "pencil")
            }
            .tag(2)
            .background(MatteDarkTheme.primaryBackground)
        }
        .accentColor(MatteDarkTheme.accent)
    }
}

#Preview {
    ContentView()
}
