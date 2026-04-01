import SwiftUI

enum AppTheme {
    // MARK: - Core Palette
    static let starWarsYellow = Color(red: 1.0, green: 0.84, blue: 0.0)
    static let lightsaberBlue = Color(red: 0.3, green: 0.6, blue: 1.0)
    static let lightsaberGreen = Color(red: 0.2, green: 0.9, blue: 0.4)
    static let imperialRed = Color(red: 0.9, green: 0.2, blue: 0.2)
    static let darkBackground = Color(red: 0.03, green: 0.03, blue: 0.08)

    // MARK: - Feedback Colors
    static let correctGreen = Color(red: 0.15, green: 0.85, blue: 0.45)
    static let wrongRed = Color(red: 0.95, green: 0.25, blue: 0.25)

    // MARK: - Surface Colors
    static let cardBackground = Color.white.opacity(0.06)
    static let cardBorder = Color.white.opacity(0.1)

    // MARK: - Background
    static let backgroundGradient = LinearGradient(
        colors: [
            Color(red: 0.07, green: 0.07, blue: 0.09),
            Color(red: 0.10, green: 0.10, blue: 0.13),
            Color(red: 0.07, green: 0.07, blue: 0.09),
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    // MARK: - Fonts
    static func titleFont(size: CGFloat = 32) -> Font {
        .system(size: size, weight: .black, design: .default)
    }

    static func bodyFont(size: CGFloat = 17) -> Font {
        .system(size: size, weight: .regular, design: .rounded)
    }
}

// MARK: - Starfield Background

struct StarfieldView: View {
    let starCount: Int

    init(starCount: Int = 120) {
        self.starCount = starCount
    }

    var body: some View {
        Canvas { context, size in
            var rng = SeededRandomNumberGenerator(seed: 42)
            for _ in 0..<starCount {
                let x = CGFloat.random(in: 0...size.width, using: &rng)
                let y = CGFloat.random(in: 0...size.height, using: &rng)
                let radius = CGFloat.random(in: 0.3...1.8, using: &rng)
                let opacity = Double.random(in: 0.2...0.8, using: &rng)
                let rect = CGRect(x: x - radius, y: y - radius, width: radius * 2, height: radius * 2)
                context.opacity = opacity
                context.fill(Circle().path(in: rect), with: .color(.white))
            }
        }
        .ignoresSafeArea()
    }
}

private struct SeededRandomNumberGenerator: RandomNumberGenerator {
    private var state: UInt64

    init(seed: UInt64) {
        state = seed
    }

    mutating func next() -> UInt64 {
        state &+= 0x9e3779b97f4a7c15
        var z = state
        z = (z ^ (z >> 30)) &* 0xbf58476d1ce4e5b9
        z = (z ^ (z >> 27)) &* 0x94d049bb133111eb
        return z ^ (z >> 31)
    }
}

// MARK: - Themed Background Modifier

struct ThemedBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                AppTheme.backgroundGradient
                    .ignoresSafeArea()
            }
    }
}

extension View {
    func themedBackground() -> some View {
        modifier(ThemedBackground())
    }
}

// MARK: - Glow Modifier

extension View {
    func glowEffect(color: Color, radius: CGFloat = 8) -> some View {
        self
            .shadow(color: color.opacity(0.6), radius: radius / 2)
            .shadow(color: color.opacity(0.3), radius: radius)
    }
}
