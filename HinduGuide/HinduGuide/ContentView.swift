import SwiftUI

struct ContentView: View {
    @State private var showingChat = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button("Open Hindu Guide Chat") {
                    showingChat = true
                }
                .sheet(isPresented: $showingChat) {
                    ChatView()
                }

                Button("Send Daily Verse Notification") {
                    NotificationManager.shared.scheduleDailyVerse()
                }
            }
            .navigationTitle("Hindu Guide")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
