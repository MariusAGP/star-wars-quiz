import Foundation

enum QuestionType: Hashable, Sendable {
    case multipleChoice
    case trueFalse
    case imageQuestion
}

struct Question: Identifiable, Hashable, Sendable {
    let id: UUID
    let type: QuestionType
    let text: String
    let imageName: String?
    let options: [String]
    let correctAnswerIndex: Int
    let explanation: String?

    init(
        id: UUID = UUID(),
        type: QuestionType,
        text: String,
        imageName: String? = nil,
        options: [String],
        correctAnswerIndex: Int,
        explanation: String? = nil
    ) {
        self.id = id
        self.type = type
        self.text = text
        self.imageName = imageName
        self.options = options
        self.correctAnswerIndex = correctAnswerIndex
        self.explanation = explanation
    }
}
