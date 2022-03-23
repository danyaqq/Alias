//
//  HowToPlayViewController.swift
//  Alias
//
//  Created by Даня on 22.02.2022.
//

import UIKit

class HowToPlayViewController: UIViewController {
    
//MARK: - Properties
    
    let firstText = "Alias: Скажи иначе\nВ игру играют командами из двух или более человек, Задача каждого игрока команды объяснить как можно больше слов отображаемых на экране за ограниченное время другими словами, используя, например, синонимы, антонимы и подсказки так, чтобы члены вашей команды смогли отгадать как можно больше слов прежде чем истечет время. Чем больше слов отгадала команда, тем больше она. заработает баллов."
    let secondText = "Объяснение слов\nПри объяснении слов нельзя упоминать какую-либо часть слова. Например, слово кофеварка» нельзя объяснять как «аппарат для варки кофе. Правильный способ, объяснения будет следующий: «аппарат для приготовления крепкого напитка, который обычно пьют за завтраком» Можно сказать «кипятить» но не «варить»\n\nВы можете использовать антонимы. Слово «большой» может быть объяснено как (антоним слова маленький». Вы не может еиспользовать иностранные языки за исключением тех случаев когда все игроки\n\nОтгаданное слово должно точно совпадать. Объясняющий игрок помогает отгадывающим найти правильную форму слова. Если слово состоит из двух частей и кто-то отгадывает первую часть, вы потом можете использовать эту часть слова в дальнейшем объяснении"
    let thirdText = "Начисление очков\nЗа каждое отгаданное слово командаполучает одно очко, а за пропущенное или отгаданное с нарушением - штрафуется (в зависимости от настроек)\n\nЕсли объясняющий игрок допускает ошибку например, называет часть слова, указанного в карточке, слово не будет принято команда потеряет 1 очко. Поэтому каждая команда должна внимательно слушать объяснения других команд Если слово пропустить но помните, то за это вы потеряете очки. Однако, иногда это того стоит. так как вы можете сэкономить время,\n\nПоследнее слово для всех - если включена. эта опция по истечении времени раунда, слово могут отгадывать все команды. В этом случае 1 очко получит команда отгадавшее слово.\n\nПобедителем считается команда, набравшая необходимое для победы количество очков Если на момент завершения победного раунда у команд одинаковое количество очков - проводиться дополнительный раунд (Овертайм)"
    let fourthText = "Задания\nЕсли в раунде есть задание -команда может получить бонусные балы за его выполнение\n\nЕсли вам удастся объяснить все слова в соответствии с заданием, то ваша команда получает бонусные очки, но только если другие команды считают ваше выполнение убедительным. Количество бонусных балов определяется случайно В интервале от 7 до 10."
    
    //MARK: - Views
    
    let scrollView = UIScrollView()
    
    lazy var rulesLabel: UILabel = {
        let label = UILabel()
        label.boldString(text: String(firstText), boldText: "Alias: Скажи иначе")
        label.numberOfLines = 0
        label.textColor = .black
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var explanationOfWordLabel: UILabel = {
        let label = UILabel()
        label.boldString(text: String(secondText), boldText: "Объяснение слов")
        label.numberOfLines = 0
        label.textColor = .black
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var scoringPointsLabel: UILabel = {
        let label = UILabel()
        label.boldString(text: String(thirdText), boldText: "Начисление очков")
        label.numberOfLines = 0
        label.textColor = .black
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tasksLabel: UILabel = {
        let label = UILabel()
        label.boldString(text: String(fourthText), boldText: "Задания")
        label.numberOfLines = 0
        label.textColor = .black
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [rulesLabel, explanationOfWordLabel, scoringPointsLabel, tasksLabel])
        stack.spacing = 20
        stack.axis = .vertical
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupScrollView()
        setupConstraints()
    }
    
    func setupViews(){
        title = "Правила игры"
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(scrollView)

        let stopBarButtonItem = UIBarButtonItem(title: "← Назад", style: .done, target: self, action: #selector(dismissButtonAction))
        stopBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = stopBarButtonItem
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.barTintColor = UIColor(named: "background")
        
    }
    
    func setupScrollView(){
        scrollView.addSubview(stackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints(){
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 5/6).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    @objc
    func dismissButtonAction(){
        self.navigationController?.popToRootViewController(animated: true)
    }
}
