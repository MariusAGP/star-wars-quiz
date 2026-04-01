import Foundation

enum QuizDataService {
    static func allQuestions() -> [Question] {
        [
            Question(
                type: .multipleChoice,
                text: "What color is Mace Windu's lightsaber?",
                options: ["Blue", "Green", "Purple", "Red"],
                correctAnswerIndex: 2,
                explanation: "Samuel L. Jackson requested a purple lightsaber so he could spot himself in battle scenes."
            ),
            Question(
                type: .multipleChoice,
                text: "Who is Luke Skywalker's father?",
                options: ["Obi-Wan Kenobi", "Darth Vader", "Han Solo", "Emperor Palpatine"],
                correctAnswerIndex: 1
            ),
            Question(
                type: .multipleChoice,
                text: "What planet is the Jedi Temple located on?",
                options: ["Naboo", "Tatooine", "Coruscant", "Kamino"],
                correctAnswerIndex: 2
            ),
            Question(
                type: .multipleChoice,
                text: "Which bounty hunter captures Han Solo?",
                options: ["Bossk", "Dengar", "Boba Fett", "IG-88"],
                correctAnswerIndex: 2,
                explanation: "Boba Fett tracked the Millennium Falcon to Cloud City."
            ),
            Question(
                type: .multipleChoice,
                text: "What is the name of Han Solo's ship?",
                options: ["X-Wing", "TIE Fighter", "Millennium Falcon", "Star Destroyer"],
                correctAnswerIndex: 2
            ),
            Question(
                type: .multipleChoice,
                text: "What species is Chewbacca?",
                options: ["Ewok", "Wookiee", "Gungan", "Tusken Raider"],
                correctAnswerIndex: 1
            ),
            Question(
                type: .multipleChoice,
                text: "In which episode does Anakin become Darth Vader?",
                options: ["Episode I", "Episode II", "Episode III", "Episode IV"],
                correctAnswerIndex: 2,
                explanation: "Revenge of the Sith shows Anakin's turn to the dark side."
            ),


            Question(
                type: .trueFalse,
                text: "Yoda trained Obi-Wan Kenobi as his Padawan.",
                options: ["True", "False"],
                correctAnswerIndex: 1,
                explanation: "Qui-Gon Jinn trained Obi-Wan. Yoda trained Count Dooku and later Luke."
            ),
            Question(
                type: .trueFalse,
                text: "The Death Star was destroyed twice in the original trilogy.",
                options: ["True", "False"],
                correctAnswerIndex: 0
            ),
            Question(
                type: .trueFalse,
                text: "Chewbacca is a Wookiee from the planet Kashyyyk.",
                options: ["True", "False"],
                correctAnswerIndex: 0
            ),
            Question(
                type: .trueFalse,
                text: "Darth Maul has a single-bladed lightsaber.",
                options: ["True", "False"],
                correctAnswerIndex: 1,
                explanation: "Darth Maul wields a double-bladed lightsaber."
            ),
            Question(
                type: .trueFalse,
                text: "Anakin Skywalker was born on Tatooine.",
                options: ["True", "False"],
                correctAnswerIndex: 0
            ),


            Question(
                type: .imageQuestion,
                text: "Who is this character?",
                imageName: "yoda",
                options: ["Mace Windu", "Yoda", "Ki-Adi-Mundi", "Plo Koon"],
                correctAnswerIndex: 1,
                explanation: "Yoda is the legendary Jedi Grand Master who trained Jedi for over 800 years."
            ),
            Question(
                type: .imageQuestion,
                text: "What is the name of this ship?",
                imageName: "millennium-falcon",
                options: ["Slave I", "Millennium Falcon", "Ghost", "Razor Crest"],
                correctAnswerIndex: 1,
                explanation: "The Millennium Falcon is Han Solo's famous Corellian freighter."
            ),
            Question(
                type: .imageQuestion,
                text: "Who is this Sith Lord?",
                imageName: "darth-vader",
                options: ["Darth Maul", "Darth Sidious", "Darth Vader", "Kylo Ren"],
                correctAnswerIndex: 2
            ),
            Question(
                type: .imageQuestion,
                text: "What is the name of this droid?",
                imageName: "r2d2",
                options: ["BB-8", "C-3PO", "R2-D2", "K-2SO"],
                correctAnswerIndex: 2,
                explanation: "R2-D2 is the resourceful astromech droid who served Anakin and Luke Skywalker."
            ),
            Question(
                type: .imageQuestion,
                text: "What is this space station called?",
                imageName: "death-star",
                options: ["Starkiller Base", "Death Star", "Star Forge", "Citadel Station"],
                correctAnswerIndex: 1,
                explanation: "The Death Star was the Empire's moon-sized superweapon."
            ),


            Question(
                type: .matching,
                text: "Match each character to their home planet:",
                matchingPairs: [
                    MatchingPair(left: "Luke Skywalker", right: "Tatooine"),
                    MatchingPair(left: "Padmé Amidala", right: "Naboo"),
                    MatchingPair(left: "Chewbacca", right: "Kashyyyk"),
                    MatchingPair(left: "Lando Calrissian", right: "Socorro"),
                ]
            ),
            Question(
                type: .matching,
                text: "Match each ship to its pilot:",
                explanation: "Anakin flew a Naboo Starfighter during the Battle of Naboo in Episode I.",
                matchingPairs: [
                    MatchingPair(left: "Millennium Falcon", right: "Han Solo"),
                    MatchingPair(left: "Slave I", right: "Boba Fett"),
                    MatchingPair(left: "X-Wing (Red Five)", right: "Luke Skywalker"),
                    MatchingPair(left: "Naboo Starfighter", right: "Anakin Skywalker"),
                ]
            ),
            Question(
                type: .matching,
                text: "Match each lightsaber color to its wielder:",
                matchingPairs: [
                    MatchingPair(left: "Purple", right: "Mace Windu"),
                    MatchingPair(left: "Green", right: "Yoda"),
                    MatchingPair(left: "Red (dual)", right: "Darth Maul"),
                    MatchingPair(left: "White", right: "Ahsoka Tano"),
                ]
            ),
        ]
    }

    static func quizQuestions(count: Int = 10) -> [Question] {
        Array(allQuestions().shuffled().prefix(count))
    }
}
