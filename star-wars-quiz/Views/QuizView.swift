import SwiftUI

struct QuizView: View {
    let viewModel: QuizViewModel

    var body: some View {
        VStack(spacing: 16) {
            // Header
            VStack(spacing: 10) {
                StarWarsProgressBar(progress: viewModel.progress)

                Text("Question \(viewModel.currentQuestionIndex + 1) of \(viewModel.questions.count)")
                    .font(.system(size: 13, weight: .medium, design: .monospaced))
                    .tracking(1)
                    .foregroundStyle(.white.opacity(0.4))
            }
            .padding(.top, 8)

            Spacer()

            if let question = viewModel.currentQuestion {
                Group {
                    switch question.type {
                    case .multipleChoice:
                        MultipleChoiceView(question: question, viewModel: viewModel)
                    case .trueFalse:
                        TrueFalseView(question: question, viewModel: viewModel)
                    case .imageQuestion:
                        ImageQuestionView(question: question, viewModel: viewModel)
                    }
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
                .id(question.id)
            }

            Spacer()

            if viewModel.hasAnswered {
                Button(viewModel.isLastQuestion ? "See Results" : "Next Question") {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        viewModel.nextQuestion()
                    }
                }
                .buttonStyle(StarWarsButtonStyle())
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .padding()
        .themedBackground()
        .animation(.easeInOut(duration: 0.25), value: viewModel.hasAnswered)
    }
}
