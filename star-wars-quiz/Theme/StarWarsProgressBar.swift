import SwiftUI

struct StarWarsProgressBar: View {
    let progress: Double

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white.opacity(0.08))

                RoundedRectangle(cornerRadius: 4)
                    .fill(
                        LinearGradient(
                            colors: [
                                AppTheme.lightsaberBlue.opacity(0.8),
                                AppTheme.lightsaberBlue,
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: max(0, geo.size.width * progress))
                    .shadow(color: AppTheme.lightsaberBlue.opacity(0.8), radius: 6)
                    .shadow(color: AppTheme.lightsaberBlue.opacity(0.4), radius: 12)
                    .animation(.easeInOut(duration: 0.3), value: progress)
            }
        }
        .frame(height: 6)
    }
}
