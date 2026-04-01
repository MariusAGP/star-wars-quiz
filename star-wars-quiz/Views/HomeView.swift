import SwiftUI

struct HomeView: View {
    let viewModel: QuizViewModel

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Title block
            VStack(spacing: 4) {
                Text("STAR WARS")
                    .font(.system(size: 46, weight: .black))
                    .tracking(6)
                    .foregroundStyle(AppTheme.starWarsYellow)
                    .glowEffect(color: AppTheme.starWarsYellow, radius: 12)

                Text("QUIZ")
                    .font(.system(size: 22, weight: .heavy))
                    .tracking(14)
                    .foregroundStyle(AppTheme.starWarsYellow.opacity(0.7))
            }
            .padding(.bottom, 32)

            // Decorative divider
            HStack(spacing: 12) {
                line
                Image(systemName: "sparkle")
                    .font(.system(size: 10))
                    .foregroundStyle(AppTheme.starWarsYellow.opacity(0.5))
                line
            }
            .frame(width: 180)
            .padding(.bottom, 32)

            // Tagline
            Text("Test your knowledge of the galaxy\nfar, far away...")
                .font(AppTheme.bodyFont(size: 16))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.5))
                .italic()
                .padding(.bottom, 40)

            Button("Start Quiz") {
                viewModel.startQuiz()
            }
            .buttonStyle(StarWarsButtonStyle())

            Spacer()
            Spacer()
        }
        .themedBackground()
    }

    private var line: some View {
        Rectangle()
            .fill(AppTheme.starWarsYellow.opacity(0.3))
            .frame(height: 1)
    }
}
