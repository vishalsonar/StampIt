import SwiftUI

struct AddTravelEntry: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var resetTrigger: Int
    
    @State private var country: String = Constants.EMPTY
    @State private var city: String = Constants.EMPTY
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var note: String = Constants.EMPTY
    
    @StateObject private var toastManager = ToastManager()
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(Constants.ADD_NEW_JOURNEY).font(.title2.bold()).foregroundColor(MatteDarkTheme.textPrimary).padding(.top)
                    CustomTextField(title: Constants.COUNTRY, systemIcon: Constants.ICON_GLOBE, text: $country, maxLength: 30)
                    CustomTextField(title: Constants.CITY, systemIcon: Constants.ICON_BUILDING_CROP_CIRCLE, text: $city, maxLength: 30)
                    HStack {
                        CustomDatePicker(title: Constants.START_DATE, date: $startDate)
                        CustomDatePicker(title: Constants.END_DATE, date: $endDate)
                    }
                    CustomTextField(title: Constants.NOTES, systemIcon: Constants.ICON_NOTE_TEXT, text: $note, maxLength: 30)
                    HStack {
                        Button(action: save) {
                            HStack {
                                Image(systemName: Constants.ICON_PLUS_CIRCLE)
                                Text(Constants.SAVE).fontWeight(.semibold)
                            }
                            .foregroundColor(MatteDarkTheme.primaryBackground)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(MatteDarkTheme.accent)
                            .cornerRadius(12)
                            .shadow(radius: 6)
                        }
                        Button(action: reset) {
                            HStack {
                                Image(systemName: Constants.ICON_ARROW_COUNTERCLOCKWISE_CIRCLE)
                                Text(Constants.RESET).fontWeight(.semibold)
                            }
                            .foregroundColor(MatteDarkTheme.primaryBackground)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(MatteDarkTheme.accent)
                            .cornerRadius(12)
                            .shadow(radius: 6)
                        }
                    }
                }
                .padding()
            }.onChange(of: resetTrigger) {
                if resetTrigger == 0 {
                    reset()
                }
            }
            ToastMessage(toastManager: toastManager)
        }
    }
    
    private func reset() {
        country = Constants.EMPTY
        city = Constants.EMPTY
        startDate = Date()
        endDate = Date()
        note = Constants.EMPTY
    }
    
    private func save() {
        if country.trimmingCharacters(in: .whitespaces).isEmpty {
            toastManager.show("Please enter a country")
            return
        }
        if !Constants.STRIN_PREDICATE.evaluate(with: country) {
            toastManager.show("Country can only contain letters")
            return
        }
        if city.trimmingCharacters(in: .whitespaces).isEmpty {
            toastManager.show("Please enter a city")
            return
        }
        if !Constants.STRIN_PREDICATE.evaluate(with: city) {
            toastManager.show("City can only contain letters")
            return
        }
        if endDate < startDate {
            toastManager.show("End date cannot be before start date")
            return
        }
        if endDate == startDate {
            toastManager.show("End date cannot be same as start date")
            return
        }
        if note.count > 30 {
            toastManager.show("Notes cannot exceed 30 characters")
            return
        }
        
        FirestoreService().saveJourney(country: country, city: city, startDate: startDate, endDate: endDate, note: note) { result in
            switch result {
            case .success:
                toastManager.show("Journey saved successfully.")
                reset()
            case .failure(let _error):
                toastManager.show("Failed to save.")
            }
        }
        dismiss()
    }
}
