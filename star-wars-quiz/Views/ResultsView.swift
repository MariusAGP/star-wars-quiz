import SwiftUI

struct ResultsView: View {
    let viewModel: QuizViewModel

    private var result: QuizResult { viewModel.result }

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Rank icon
            Image(systemName: result.rank.iconName)
                .font(.system(size: 70))
                .foregroundStyle(AppTheme.starWarsYellow)
                .glowEffect(color: AppTheme.starWarsYellow, radius: 16)
                .padding(.bottom, 20)

            // Rank title
            Text(result.rank.rawValue.uppercased())
                .font(.system(size: 24, weight: .black))
                .tracking(4)
                .foregroundStyle(AppTheme.starWarsYellow)
                .padding(.bottom, 24)

            // Score
            Text("\(result.correctAnswers) / \(result.totalQuestions)")
                .font(.system(size: 52, weight: .heavy, design: .monospaced))
                .foregroundStyle(.white)
                .padding(.bottom, 12)

            // Message
            Text(result.rank.message)
                .font(.title3)
                .foregroundStyle(.white.opacity(0.6))
                .multilineTextAlignment(.center)
                .italic()
                .padding(.horizontal, 32)

            Spacer()

            Button("Play Again") {
                viewModel.restartQuiz()
            }
            .buttonStyle(StarWarsButtonStyle())

            Spacer()
        }
        .themedBackground()
    }
}
