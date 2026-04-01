import SwiftUI

struct TrueFalseView: View {
    let question: Question
    let viewModel: QuizViewModel

    var body: some View {
        VStack(spacing: 24) {
            Text(question.text)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)

            HStack(spacing: 16) {
                ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                    Button {
                        viewModel.selectAnswer(index)
                    } label: {
                        Text(option.uppercased())
                            .font(.system(size: 18, weight: .bold, design: .monospaced))
                            .tracking(2)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 28)
                            .background(backgroundColor(for: index))
                            .foregroundStyle(foregroundColor(for: index))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(borderColor(for: index), lineWidth: borderWidth(for: index))
                            )
                    }
                    .disabled(viewModel.hasAnswered)
                }
            }

            if viewModel.hasAnswered, let explanation = question.explanation {
                Text(explanation)
                    .font(.caption)
                    .foregroundStyle(AppTheme.starWarsYellow.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                    .transition(.opacity)
            }
        }
    }

    private func foregroundColor(for index: Int) -> Color {
        guard viewModel.hasAnswered else { return .white }
        if index == question.correctAnswerIndex {
            return AppTheme.correctGreen
        }
        if index == viewModel.selectedAnswerIndex {
            return AppTheme.wrongRed
        }
        return .white.opacity(0.3)
    }

    private func backgroundColor(for index: Int) -> Color {
        guard viewModel.hasAnswered else {
            return AppTheme.cardBackground
        }
        if index == question.correctAnswerIndex {
            return AppTheme.correctGreen.opacity(0.15)
        }
        if index == viewModel.selectedAnswerIndex {
            return AppTheme.wrongRed.opacity(0.15)
        }
        return AppTheme.cardBackground.opacity(0.3)
    }

    private func borderColor(for index: Int) -> Color {
        guard viewModel.hasAnswered else {
            return AppTheme.cardBorder
        }
        if index == question.correctAnswerIndex {
            return AppTheme.correctGreen.opacity(0.5)
        }
        if index == viewModel.selectedAnswerIndex {
            return AppTheme.wrongRed.opacity(0.5)
        }
        return .clear
    }

    private func borderWidth(for index: Int) -> CGFloat {
        guard viewModel.hasAnswered else { return 1 }
        if index == question.correctAnswerIndex || index == viewModel.selectedAnswerIndex {
            return 1.5
        }
        return 0
    }
}
