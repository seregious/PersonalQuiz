//
//  QuestionsViewController.swift
//  PersonalQuiz
//
//  Created by Сергей Иванчихин on 07.04.2022.
//

import UIKit

class QuestionsViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionProgressView: UIProgressView!

    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!

    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!

    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet weak var rangedSlider: UISlider! {
        didSet {
            let answersCount = Float(currentAnswers.count - 1)
            rangedSlider.maximumValue = answersCount
            rangedSlider.value = answersCount / 2
        }
    }

    private let questions = Question.getQuenstions()
    private var answersChosen: [Answer] = []
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    private var questionIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let ResultVC = segue.destination as? ResultViewController else {return}
        ResultVC.answers = answersChosen
    }

    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else {return}
        let currentAnswer = currentAnswers[buttonIndex]
        answersChosen.append(currentAnswer)

        nextQuestion()
    }
    @IBAction func multipleAnswerButtonPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answersChosen.append(answer)
            }
        }
        nextQuestion()
    }

    @IBAction func rangedAnswerButtonPressed() {
        let index = lrintf(rangedSlider.value)
        answersChosen.append(currentAnswers[index])
        nextQuestion()
    }
}

extension QuestionsViewController {
    private func updateUI() {
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }

        let currentQuestion = questions[questionIndex]
        questionLabel.text = currentQuestion.title

        let totalProgress = Float(questionIndex) / Float(questions.count)
        questionProgressView.setProgress(totalProgress, animated: true)

        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"

        showCurrentAnswers(for: currentQuestion.type)
    }


    private func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single:
            showSingleStackView(with: currentAnswers)
        case .multiple:
            showMultipleStackView(with: currentAnswers)
        case .ranged:
            showRangedStackView(with: currentAnswers)
        }
    }

    private func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden.toggle()

        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }

    private func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden.toggle()

        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }

    private func showRangedStackView(with answers: [Answer]) {
        rangedStackView.isHidden.toggle()

        rangedLabels.first?.text = answers.first?.title
        rangedLabels.last?.text = answers.last?.title
    }

    private func nextQuestion() {
        questionIndex += 1

        if questionIndex < questions.count {
            updateUI()
            return
        }
        performSegue(withIdentifier: "showResult", sender: nil)
    }

}
