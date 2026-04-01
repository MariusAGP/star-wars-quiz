import SwiftUI

struct StarWarsProgressBar: View {
    let progress: Double

    private let hiltWidth: CGFloat = 32
    private let bladeHeight: CGFloat = 10
    private let hiltHeight: CGFloat = 18

    var body: some View {
        GeometryReader { geo in
            let bladeMaxWidth = geo.size.width - hiltWidth - 4
            let bladeWidth = max(0, bladeMaxWidth * progress)

            HStack(spacing: 0) {
                // Lightsaber hilt
                HStack(spacing: 0) {
                    // Grip section
                    RoundedRectangle(cornerRadius: 3)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(white: 0.45),
                                    Color(white: 0.55),
                                    Color(white: 0.40),
                                    Color(white: 0.50),
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 22, height: hiltHeight)
                        .overlay(
                            // Grip ridges
                            HStack(spacing: 3) {
                                ForEach(0..<3, id: \.self) { _ in
                                    Rectangle()
                                        .fill(Color.white.opacity(0.3))
                                        .frame(width: 1)
                                }
                            }
                        )

                    // Emitter
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(white: 0.50),
                                    Color(white: 0.65),
                                    Color(white: 0.45),
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 10, height: hiltHeight - 4)
                }
                .frame(width: hiltWidth)

                // Lightsaber blade
                ZStack(alignment: .leading) {
                    // Track
                    Capsule()
                        .fill(Color.white.opacity(0.06))
                        .frame(height: bladeHeight)

                    // Blade glow
                    if bladeWidth > 0 {
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.white,
                                        AppTheme.lightsaberBlue.opacity(0.9),
                                        AppTheme.lightsaberBlue,
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: bladeWidth, height: bladeHeight)
                            .shadow(color: AppTheme.lightsaberBlue.opacity(0.9), radius: 8)
                            .shadow(color: AppTheme.lightsaberBlue.opacity(0.5), radius: 16)
                            .animation(.easeInOut(duration: 0.4), value: progress)
                    }
                }
                .padding(.leading, 4)
            }
            .frame(height: hiltHeight)
        }
        .frame(height: 18)
    }
}
