import SwiftUI
import AVFoundation

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    private let synthesizer = AVSpeechSynthesizer()

    func sendMessage(_ text: String) {
        messages.append(Message(text: text, isUser: true))
        respond(to: text)
    }

    private func respond(to text: String) {
        // Placeholder AI logic
        let response = "AI guide says: \(text)"
        messages.append(Message(text: response, isUser: false))
        speak(response)
    }

    private func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        synthesizer.speak(utterance)
    }
}

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var inputText = ""

    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.messages) { message in
                    HStack {
                        if message.isUser {
                            Spacer()
                        }
                        Text(message.text)
                            .padding()
                            .background(message.isUser ? Color.blue.opacity(0.3) : Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        if !message.isUser {
                            Spacer()
                        }
                    }
                }
            }
            HStack {
                TextField("Type here", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Send") {
                    let text = inputText
                    inputText = ""
                    viewModel.sendMessage(text)
                }
            }
            .padding()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
