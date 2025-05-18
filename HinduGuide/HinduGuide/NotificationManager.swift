import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    private init() {}

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification auth error: \(error)")
            }
        }
    }

    func scheduleDailyVerse() {
        let content = UNMutableNotificationContent()
        content.title = "Daily Verse"
        content.body = randomVerse()
        content.sound = .default

        var date = DateComponents()
        date.hour = 9
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    private func randomVerse() -> String {
        let verses = [
            "You have the right to work, but never to the fruit of work. - Bhagavad Gita 2.47",
            "When meditation is mastered, the mind is unwavering like the flame of a lamp in a windless place. - Bhagavad Gita 6.19",
            "Truth alone triumphs, never untruth. - Mundaka Upanishad 3.1.6"
        ]
        return verses.randomElement() ?? "Om"
    }
}
