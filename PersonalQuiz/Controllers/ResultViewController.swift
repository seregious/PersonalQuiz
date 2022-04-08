//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Сергей Иванчихин on 07.04.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var animalTypeLabel: UILabel!
    @IBOutlet weak var descriptionTypeLabel: UILabel!
    
    var answers: [Answer]!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        determiningResult(for: answers)
    }
    


}

extension ResultViewController {
    private func updateUI(animal: Animal) {
        animalTypeLabel.text = "Вы = \(animal.rawValue)!"
        descriptionTypeLabel.text = animal.definition
    }
    
    private func determiningResult(for answers: [Answer]) {
        var animalsFrequency: [Animal : Int] = [:]
        let animals = answers.map{$0.animal}
        
        for animal in animals {
            animalsFrequency[animal] = (animalsFrequency[animal] ?? 0) + 1
        }
        let sortedAnimalFrequency = animalsFrequency.sorted {$0.value > $1.value}
        guard let resultAnimal = sortedAnimalFrequency.first?.key else {return}
        
        updateUI(animal: resultAnimal)
    }
}
