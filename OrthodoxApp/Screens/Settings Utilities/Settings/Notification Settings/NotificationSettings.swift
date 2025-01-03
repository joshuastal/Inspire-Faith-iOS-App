import Foundation
import SwiftUI
import UserNotifications
import Combine

class NotificationSettings: ObservableObject {
    @AppStorage("notificationHour") private var hour: Int = 8
        @AppStorage("notificationMinute") private var minute: Int = 0
        private var cancellables = Set<AnyCancellable>()
        @Published private(set) var notificationTime: Date
        
        // Add a reference to QuotesViewModel
        private weak var quotesViewModel: QuotesViewModel?
        
        init(quotesViewModel: QuotesViewModel? = nil) {
            self.quotesViewModel = quotesViewModel
            let tempComponents = DateComponents(hour: 8, minute: 0)
            self.notificationTime = Calendar.current.date(from: tempComponents) ?? Date()
            
            DispatchQueue.main.async {
                let components = DateComponents(hour: self.hour, minute: self.minute)
                if let date = Calendar.current.date(from: components) {
                    self.notificationTime = date
                }
                
                self.$notificationTime
                    .sink { [weak self] newDate in
                        guard let self = self else { return }
                        let components = Calendar.current.dateComponents([.hour, .minute], from: newDate)
                        self.hour = components.hour ?? 8
                        self.minute = components.minute ?? 0
                        
                        // Trigger notification reschedule when time changes
                        if let viewModel = self.quotesViewModel {
                            rescheduleNotifications(viewModel: viewModel)
                        }
                    }
                    .store(in: &self.cancellables)
            }
        }
    
    // Add this method to update the notification time
    func updateNotificationTime(_ newTime: Date) {
            notificationTime = newTime
            print("Time updated to: \(formattedTime)")  // Add this debug print
        }
    
    var formattedTime: String {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: notificationTime)
        }
    
    // Add a binding property for SwiftUI
    var notificationTimeBinding: Binding<Date> {
        Binding(
            get: { self.notificationTime },
            set: { self.updateNotificationTime($0) }
        )
    }
}
