import SwiftUI

struct ContentView: View {
    @State private var viewModel = QuizViewModel()

    var body: some View {
        Group {
            switch viewModel.state {
            case .notStarted:
                HomeView(viewModel: viewModel)
            case .inProgress:
                QuizView(viewModel: viewModel)
            case .finished:
                ResultsView(viewModel: viewModel)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.state)
    }
}

#Preview {
    ContentView()
}
