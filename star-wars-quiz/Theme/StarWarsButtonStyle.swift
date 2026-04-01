import SwiftUI

struct StarWarsButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 17, weight: .bold, design: .monospaced))
            .tracking(2)
            .textCase(.uppercase)
            .foregroundStyle(.black)
            .padding(.horizontal, 48)
            .padding(.vertical, 16)
            .background(
                AppTheme.starWarsYellow
                    .shadow(.inner(color: .white.opacity(0.3), radius: 1, y: 1))
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(AppTheme.starWarsYellow.opacity(0.6), lineWidth: 1)
            )
            .shadow(color: AppTheme.starWarsYellow.opacity(configuration.isPressed ? 0.1 : 0.5), radius: configuration.isPressed ? 4 : 16)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}
