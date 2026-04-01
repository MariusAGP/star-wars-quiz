import SwiftUI

struct ImageQuestionView: View {
    let question: Question
    let viewModel: QuizViewModel

    var body: some View {
        VStack(spacing: 14) {
            if let imageName = question.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(AppTheme.cardBorder, lineWidth: 1)
                    )
                    .padding(.bottom, 4)
            }

            Text(question.text)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.bottom, 4)

            ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                Button {
                    viewModel.selectAnswer(index)
                } label: {
                    HStack {
                        Text(optionLabel(index))
                            .font(.system(size: 14, weight: .bold, design: .monospaced))
                            .foregroundStyle(optionLabelColor(for: index))
                            .frame(width: 28)

                        Text(option)
                            .font(AppTheme.bodyFont())
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(backgroundColor(for: index))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(borderColor(for: index), lineWidth: borderWidth(for: index))
                    )
                }
                .disabled(viewModel.hasAnswered)
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

    private func optionLabel(_ index: Int) -> String {
        let labels = ["A", "B", "C", "D", "E", "F"]
        return index < labels.count ? labels[index] : "\(index + 1)"
    }

    private func optionLabelColor(for index: Int) -> Color {
        guard viewModel.hasAnswered else {
            return AppTheme.starWarsYellow.opacity(0.6)
        }
        if index == question.correctAnswerIndex {
            return AppTheme.correctGreen
        }
        if index == viewModel.selectedAnswerIndex {
            return AppTheme.wrongRed
        }
        return .white.opacity(0.2)
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
