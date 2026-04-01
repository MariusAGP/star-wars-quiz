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

    // Matching question state
    private(set) var matchingAssignments: [String: String] = [:]  // left -> right
    private(set) var selectedLeftItem: String? = nil
    private(set) var shuffledRightItems: [String] = []

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
        prepareMatchingIfNeeded()
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
            resetMatchingState()
            prepareMatchingIfNeeded()
        }
    }

    func restartQuiz() {
        state = .notStarted
    }

    // Matching

    func selectLeftItem(_ item: String) {
        guard !hasAnswered else { return }
        selectedLeftItem = (selectedLeftItem == item) ? nil : item
    }

    func selectRightItem(_ item: String) {
        guard !hasAnswered, let left = selectedLeftItem else { return }

        // If this right item was already assigned to another left, remove that
        if let existingLeft = matchingAssignments.first(where: { $0.value == item })?.key {
            matchingAssignments.removeValue(forKey: existingLeft)
        }

        matchingAssignments[left] = item
        selectedLeftItem = nil

        // Auto-submit when all pairs are assigned
        if let pairs = currentQuestion?.matchingPairs,
           matchingAssignments.count == pairs.count {
            submitMatching()
        }
    }

    func removeMatchingAssignment(for left: String) {
        guard !hasAnswered else { return }
        matchingAssignments.removeValue(forKey: left)
    }

    private func submitMatching() {
        guard let pairs = currentQuestion?.matchingPairs else { return }
        hasAnswered = true

        let allCorrect = pairs.allSatisfy { pair in
            matchingAssignments[pair.left] == pair.right
        }
        if allCorrect {
            score += 1
        }
    }

    func matchingIsCorrect(left: String, right: String) -> Bool? {
        guard hasAnswered, let pairs = currentQuestion?.matchingPairs else { return nil }
        return pairs.contains(where: { $0.left == left && $0.right == right })
    }

    private func prepareMatchingIfNeeded() {
        guard let question = currentQuestion,
              question.type == .matching,
              let pairs = question.matchingPairs else { return }
        shuffledRightItems = pairs.map(\.right).shuffled()
    }

    private func resetMatchingState() {
        matchingAssignments = [:]
        selectedLeftItem = nil
        shuffledRightItems = []
    }
}
