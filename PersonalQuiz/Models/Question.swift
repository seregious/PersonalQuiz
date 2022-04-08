//
//  Question.swift
//  PersonalQuiz
//
//  Created by Сергей Иванчихин on 07.04.2022.
//

import Foundation

struct Question {
    let title: String
    let answers: [Answer]
    let type: ResponseType
    
    static func getQuenstions() -> [Question] {
        [
            Question(
                title: "Какую пищу вы предпочитаете?",
                answers: [
                    Answer(title: "Стейк", animal: .dog),
                    Answer(title: "Рыба", animal: .cat),
                    Answer(title: "Морковь", animal: .rabbit),
                    Answer(title: "Кукуруза", animal: .turtle),
                ],
                type: .single
            ),
            Question(
                title: "Что вам нравится больше?",
                answers: [
                    Answer(title: "Плавать", animal: .dog),
                    Answer(title: "Спать", animal: .cat),
                    Answer(title: "Обниматься", animal: .rabbit),
                    Answer(title: "Есть", animal: .turtle),
                ],
                type: .multiple
            ),
            Question(
                title: "Любите ли вы поездки на машнине",
                answers: [
                    Answer(title: "Обожаю", animal: .dog),
                    Answer(title: "Ненавижу", animal: .cat),
                    Answer(title: "Не Нервничаю", animal: .rabbit),
                    Answer(title: "Не замечаю", animal: .turtle),
                ],
                type: .ranged
            )
        ]
    }
}

struct Answer {
    let title: String
    let animal: Animal
}

enum ResponseType {
    case single, multiple, ranged
}

enum Animal: Character {
    case dog = "🐶"
    case cat = "🐱"
    case turtle = "🐢"
    case rabbit = "🐰"
    
    var definition: String {
        switch self {
        case .dog:
            return "Поздравляем! Вы в душе собака!"
        case .cat:
            return "Поздравляем! Вы в душе кот!"
        case .turtle:
            return "Поздравляем! Вы в душе черепаха!"
        case .rabbit:
            return "Поздравляем! Вы в душе кролик!"
        }
    }
}
