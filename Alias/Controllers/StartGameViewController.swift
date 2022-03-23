//
//  StartGameViewController.swift
//  Alias
//
//  Created by Даня on 22.02.2022.
//

import UIKit

class StartGameViewController: UIViewController {
    
    //MARK: - Properties
    var gameDataModel = AliasDataModel()
    
    var selectedTime: Int = 60
    
    var categories = [Category(name: "Животныe", image: "turtle", words: [Word(title: "Кошка"), Word(title: "Собака"),Word(title: "Крот"),Word(title: "Бык"), Word(title: "Лев"), Word(title: "Орёл"), Word(title: "Волк"), Word(title: "Хомяк")]),
                      Category(name: "Растения", image: "plant", words: [Word(title: "Кактус"), Word(title: "Ромашка")]),
                      Category(name: "Знаменитости", image: "celebrity", words: [Word(title: "Путин"), Word(title: "Байден"), Word(title: "Зеленский")]),
                      Category(name: "Актёры", image: "mayor", words: [Word(title: "Ди Каприо"), Word(title: "Эндрю Гарфилд"), Word(title: "Том Холланд")])]
    var selectedCategory: Category? = nil
    //MARK: - Views
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "Категория"
        label.font = UIFont.bold(42)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Нажми на карточку, чтобы\nвыбрать категорию"
        label.font = UIFont.semiBold(21)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .black
        label.alpha = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var topStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topLabel, descriptionLabel])
        stack.spacing = 12
        stack.axis = .vertical
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.itemSize = .init(width: 200, height: 160)
        flow.sectionInset = .init(top: 0, left: 30, bottom: 0, right: 30)
        flow.minimumLineSpacing = 28
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collectionView.backgroundColor = UIColor(named: "background")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        collectionView.register(CategoryViewCell.self, forCellWithReuseIdentifier: CategoryViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время раунда"
        label.font = UIFont.bold(36)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var thirySecondButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.semiBold(24)
        button.setTitle("30 сек", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 30
        button.addTarget(self, action: #selector(buttonTimeAction), for: .touchUpInside)
        return button
    }()
    
    lazy var sixtySecondButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.semiBold(24)
        button.setTitle("60 сек", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 60
        button.addTarget(self, action: #selector(buttonTimeAction), for: .touchUpInside)
        return button
    }()
    
    lazy var ninetySecondButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.semiBold(24)
        button.setTitle("90 сек", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 90
        button.addTarget(self, action: #selector(buttonTimeAction), for: .touchUpInside)
        return button
    }()
    
    lazy var timeButtonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [thirySecondButton, sixtySecondButton, ninetySecondButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let lastWordLabel: UILabel = {
        let label = UILabel()
        label.text = "Общее последнее слово"
        label.font = UIFont.semiBold(28)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lastWordSwitch: UISwitch = {
        let switchView = UISwitch(frame: .init(x: 0, y: 0, width: 0, height: 0))
        switchView.onTintColor = UIColor(named: "timerOrange")
        switchView.tintColor = .black
        return switchView
    }()
    
    lazy var lastWordStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [lastWordLabel, lastWordSwitch])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("НАЧАТЬ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.semiBold(24)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        selectTimeButton()
        selectFirstCategory()
    }
    
    func setupView(){
        title = "Настройки игры"
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(topStackView)
        view.addSubview(collectionView)
        view.addSubview(startButton)
        view.addSubview(timeButtonStack)
        view.addSubview(lastWordStack)
        view.addSubview(timeLabel)
        
        let stopBarButtonItem = UIBarButtonItem(title: "← Назад", style: .done, target: self, action: #selector(dismissButtonAction))
        stopBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = stopBarButtonItem
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    func setupConstraints(){
        topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        topStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 24).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        timeLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 24).isActive = true
        timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        timeButtonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        timeButtonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        timeButtonStack.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 12).isActive = true
        timeButtonStack.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        lastWordStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        lastWordStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        lastWordStack.topAnchor.constraint(equalTo: timeButtonStack.bottomAnchor, constant: 36).isActive = true
        
        startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func selectTimeButton(){
        sixtySecondButton.setTitleColor(.black, for: .normal)
        sixtySecondButton.backgroundColor = .white
        sixtySecondButton.layer.cornerRadius = 8
        sixtySecondButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        sixtySecondButton.layer.borderWidth = 6
    }
    
    func selectFirstCategory(){
        if categories.count > 0{
            selectedCategory = categories[0]
        }
    }
    
    @objc
    func dismissButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func nextButtonAction(){
        gameDataModel.cateogory = selectedCategory
        gameDataModel.time = selectedTime
        gameDataModel.gameSetup()
        
        let gameVC = GameViewController()
        gameVC.gameDataModel = gameDataModel
        gameVC.time = gameDataModel.time
        gameVC.constantTimerValue = gameDataModel.time
        gameVC.callBack = { [weak self] in
            self?.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            self?.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    @objc
    func buttonTimeAction(_ sender: UIButton){
        selectedTime = sender.tag
        
        for i in [thirySecondButton, sixtySecondButton, ninetySecondButton]{
            UIView.animate(withDuration: 0.3) { [weak self] in
                if i.tag != self?.selectedTime{
                    i.setTitleColor(.white, for: .normal)
                    i.backgroundColor = .clear
                    i.layer.cornerRadius = 0
                    i.layer.borderColor = .none
                    i.layer.borderWidth = 0
                } else {
                    i.setTitleColor(.black, for: .normal)
                    i.backgroundColor = .white
                    i.layer.cornerRadius = 8
                    i.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    i.layer.borderWidth = 6
                }
            }
        }
    }
}

//MARK: - UIColletionViewDelegate & UICollectionViewDataSource

extension StartGameViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: CategoryViewCell.identifier,
                                     for: indexPath) as? CategoryViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.row]
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
