import SwiftUI


private struct MatchingAnchorKey: PreferenceKey {
    static let defaultValue: [String: Anchor<CGPoint>] = [:]
    static func reduce(value: inout [String: Anchor<CGPoint>], nextValue: () -> [String: Anchor<CGPoint>]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

struct MatchingQuestionView: View {
    let question: Question
    let viewModel: QuizViewModel

    private var pairs: [MatchingPair] {
        question.matchingPairs ?? []
    }

    private var leftItems: [String] {
        pairs.map(\.left)
    }

    var body: some View {
        VStack(spacing: 16) {
            Text(question.text)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.bottom, 4)

            // Matching columns with line overlay
            HStack(alignment: .top, spacing: 24) {
                // Left column
                VStack(spacing: 8) {
                    ForEach(leftItems, id: \.self) { item in
                        MatchingItemButton(
                            text: item,
                            state: leftItemState(for: item),
                            onTap: { viewModel.selectLeftItem(item) }
                        )
                        .anchorPreference(key: MatchingAnchorKey.self, value: .trailing) {
                            ["L_\(item)": $0]
                        }
                    }
                }

                // Right colum
                VStack(spacing: 8) {
                    ForEach(viewModel.shuffledRightItems, id: \.self) { item in
                        let isAssigned = viewModel.matchingAssignments.values.contains(item)
                        MatchingItemButton(
                            text: item,
                            state: rightItemState(for: item, isAssigned: isAssigned),
                            onTap: { viewModel.selectRightItem(item) }
                        )
                        .anchorPreference(key: MatchingAnchorKey.self, value: .leading) {
                            ["R_\(item)": $0]
                        }
                    }
                }
            }
            .overlayPreferenceValue(MatchingAnchorKey.self) { anchors in
                GeometryReader { geo in
                    ForEach(Array(viewModel.matchingAssignments.keys.sorted()), id: \.self) { leftItem in
                        if let rightItem = viewModel.matchingAssignments[leftItem],
                           let leftAnchor = anchors["L_\(leftItem)"],
                           let rightAnchor = anchors["R_\(rightItem)"] {
                            let start = geo[leftAnchor]
                            let end = geo[rightAnchor]
                            ConnectionLine(
                                start: start,
                                end: end,
                                color: lineColor(for: leftItem)
                            )
                        }
                    }
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

    // State Helpers

    private func leftItemState(for item: String) -> MatchingItemState {
        if viewModel.hasAnswered {
            if let assigned = viewModel.matchingAssignments[item] {
                let correct = viewModel.matchingIsCorrect(left: item, right: assigned) ?? false
                return correct ? .correct : .wrong
            }
            return .dimmed
        }
        if viewModel.selectedLeftItem == item { return .selected }
        if viewModel.matchingAssignments[item] != nil { return .assigned }
        return .idle
    }

    private func rightItemState(for item: String, isAssigned: Bool) -> MatchingItemState {
        if viewModel.hasAnswered {
            if let leftKey = viewModel.matchingAssignments.first(where: { $0.value == item })?.key {
                let correct = viewModel.matchingIsCorrect(left: leftKey, right: item) ?? false
                return correct ? .correct : .wrong
            }
            return .dimmed
        }
        if isAssigned { return .assigned }
        return .idle
    }

    private func lineColor(for leftItem: String) -> Color {
        if viewModel.hasAnswered {
            if let assigned = viewModel.matchingAssignments[leftItem] {
                let correct = viewModel.matchingIsCorrect(left: leftItem, right: assigned) ?? false
                return correct ? AppTheme.correctGreen : AppTheme.wrongRed
            }
        }
        return AppTheme.starWarsYellow
    }
}

// Connection Line

private struct ConnectionLine: View {
    let start: CGPoint
    let end: CGPoint
    let color: Color

    var body: some View {
        Path { path in
            path.move(to: start)
            let controlOffset = (end.x - start.x) * 0.5
            path.addCurve(
                to: end,
                control1: CGPoint(x: start.x + controlOffset, y: start.y),
                control2: CGPoint(x: end.x - controlOffset, y: end.y)
            )
        }
        .stroke(color, style: StrokeStyle(lineWidth: 2, lineCap: .round))
        .shadow(color: color.opacity(0.5), radius: 4)
        .allowsHitTesting(false)
    }
}

// Item State & Button

enum MatchingItemState {
    case idle, selected, assigned, correct, wrong, dimmed
}

private struct MatchingItemButton: View {
    let text: String
    let state: MatchingItemState
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(text)
                .font(AppTheme.bodyFont(size: 15))
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 10)
                .padding(.vertical, 12)
                .background(backgroundColor)
                .foregroundStyle(foregroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(borderColor, lineWidth: borderWidth)
                )
        }
        .disabled(state == .correct || state == .wrong || state == .dimmed)
    }

    private var backgroundColor: Color {
        switch state {
        case .idle: AppTheme.cardBackground
        case .selected: AppTheme.lightsaberBlue.opacity(0.2)
        case .assigned: AppTheme.starWarsYellow.opacity(0.1)
        case .correct: AppTheme.correctGreen.opacity(0.15)
        case .wrong: AppTheme.wrongRed.opacity(0.15)
        case .dimmed: AppTheme.cardBackground.opacity(0.3)
        }
    }

    private var foregroundColor: Color {
        switch state {
        case .idle: .white
        case .selected: AppTheme.lightsaberBlue
        case .assigned: AppTheme.starWarsYellow
        case .correct: AppTheme.correctGreen
        case .wrong: AppTheme.wrongRed
        case .dimmed: .white.opacity(0.3)
        }
    }

    private var borderColor: Color {
        switch state {
        case .idle: AppTheme.cardBorder
        case .selected: AppTheme.lightsaberBlue.opacity(0.6)
        case .assigned: AppTheme.starWarsYellow.opacity(0.3)
        case .correct: AppTheme.correctGreen.opacity(0.5)
        case .wrong: AppTheme.wrongRed.opacity(0.5)
        case .dimmed: .clear
        }
    }

    private var borderWidth: CGFloat {
        switch state {
        case .selected: 1.5
        case .correct, .wrong: 1.5
        default: 1
        }
    }
}
