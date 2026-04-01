import Foundation

enum QuestionType: Hashable, Sendable {
    case multipleChoice
    case trueFalse
    case imageQuestion
    case matching
}

struct MatchingPair: Hashable, Sendable {
    let left: String
    let right: String
}

struct Question: Identifiable, Hashable, Sendable {
    let id: UUID
    let type: QuestionType
    let text: String
    let imageName: String?
    let options: [String]
    let correctAnswerIndex: Int
    let explanation: String?
    let matchingPairs: [MatchingPair]?

    init(
        id: UUID = UUID(),
        type: QuestionType,
        text: String,
        imageName: String? = nil,
        options: [String] = [],
        correctAnswerIndex: Int = 0,
        explanation: String? = nil,
        matchingPairs: [MatchingPair]? = nil
    ) {
        self.id = id
        self.type = type
        self.text = text
        self.imageName = imageName
        self.options = options
        self.correctAnswerIndex = correctAnswerIndex
        self.explanation = explanation
        self.matchingPairs = matchingPairs
    }
}
