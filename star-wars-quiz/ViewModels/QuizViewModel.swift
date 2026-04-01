import SwiftUI

@Observable
final class QuizViewModel {
    enum QuizState: Sendable {
        case notStarted
        case inProgress
        case finished
    }

    private(set) var state: QuizState = .notStarted
    private(set) var questions: [Question] = []
    private(set) var currentQuestionIndex: Int = 0
    private(set) var score: Int = 0
    private(set) var selectedAnswerIndex: Int? = nil
    private(set) var hasAnswered: Bool = false

    var currentQuestion: Question? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }

    var progress: Double {
        guard !questions.isEmpty else { return 0 }
        return Double(currentQuestionIndex) / Double(questions.count)
    }

    var isLastQuestion: Bool {
        currentQuestionIndex == questions.count - 1
    }

    var result: QuizResult {
        QuizResult(totalQuestions: questions.count, correctAnswers: score)
    }

    func startQuiz() {
        questions = QuizDataService.quizQuestions(count: 10)
        currentQuestionIndex = 0
        score = 0
        selectedAnswerIndex = nil
        hasAnswered = false
        state = .inProgress
    }

    func selectAnswer(_ index: Int) {
        guard !hasAnswered else { return }
        selectedAnswerIndex = index
        hasAnswered = true
        if index == currentQuestion?.correctAnswerIndex {
            score += 1
        }
    }

    func nextQuestion() {
        if isLastQuestion {
            state = .finished
        } else {
            currentQuestionIndex += 1
            selectedAnswerIndex = nil
            hasAnswered = false
        }
    }

    func restartQuiz() {
        state = .notStarted
    }
}
