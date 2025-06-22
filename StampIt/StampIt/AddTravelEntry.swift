import SwiftUI

struct AddTravelEntry: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var resetTrigger: Int
    
    @State private var country: String = Constants.EMPTY
    @State private var city: String = Constants.EMPTY
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var note: String = Constants.EMPTY
    
    @State private var showToast: Bool = false
    @State private var toastMessage: String = Constants.EMPTY
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(Constants.ADD_JOURNEY).font(.title2.bold()).foregroundColor(MatteDarkTheme.textPrimary).padding(.top)
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
            
            if showToast {
                VStack {
                    Spacer()
                    Text(toastMessage).foregroundColor(MatteDarkTheme.accent)
                                      .padding()
                                      .background(MatteDarkTheme.secondaryBackground)
                                      .cornerRadius(12)
                                      .shadow(radius: 4)
                                      .padding(.bottom, 40)
                                      .transition(.move(edge: .bottom).combined(with: .opacity))
                                      .animation(.easeInOut, value: showToast)
                }
            }
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
            showToastMessage("Please enter a country")
            return
        }
        if !Constants.STRIN_PREDICATE.evaluate(with: country) {
            showToastMessage("Country can only contain letters")
            return
        }
        if city.trimmingCharacters(in: .whitespaces).isEmpty {
            showToastMessage("Please enter a city")
            return
        }
        if !Constants.STRIN_PREDICATE.evaluate(with: city) {
            showToastMessage("City can only contain letters")
            return
        }
        if endDate < startDate {
            showToastMessage("End date cannot be before start date")
            return
        }
        if note.count > 30 {
            showToastMessage("Notes cannot exceed 30 characters")
            return
        }
        
        
        print("Journey Saved:")
        print("Country: \(country)")
        print("City: \(city)")
        print("Start: \(startDate)")
        print("End: \(endDate)")
        print("Note: \(note)")
        dismiss()
    }
    
    private func showToastMessage(_ message: String) {
        toastMessage = message
        withAnimation { showToast = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation { showToast = false }
        }
    }
}
