import Foundation

struct QuizResult: Sendable {
    let totalQuestions: Int
    let correctAnswers: Int

    var percentage: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(correctAnswers) / Double(totalQuestions) * 100
    }

    var rank: StarWarsRank {
        switch percentage {
        case 90...100: return .jediMaster
        case 70..<90: return .jediKnight
        case 50..<70: return .padawan
        case 30..<50: return .youngling
        default: return .scruffy
        }
    }
}

enum StarWarsRank: String, Sendable {
    case jediMaster = "Jedi Master"
    case jediKnight = "Jedi Knight"
    case padawan = "Padawan"
    case youngling = "Youngling"
    case scruffy = "Scruffy-Looking Nerf Herder"

    var iconName: String {
        switch self {
        case .jediMaster: return "star.fill"
        case .jediKnight: return "bolt.fill"
        case .padawan: return "graduationcap.fill"
        case .youngling: return "leaf.fill"
        case .scruffy: return "tortoise.fill"
        }
    }

    var message: String {
        switch self {
        case .jediMaster: return "The Force is strong with you!"
        case .jediKnight: return "A fine addition to the Jedi Order."
        case .padawan: return "Much to learn, you still have."
        case .youngling: return "A long path ahead, the Force sees."
        case .scruffy: return "Who's scruffy-looking?"
        }
    }
}
