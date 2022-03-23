//
//  GameViewController.swift
//  Alias
//
//  Created by Даня on 22.02.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: - Properties
    var gameDataModel = AliasDataModel()
    let audioPlayer = AudioPlayer()
    
    let windowApp = UIApplication
        .shared
        .connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .first { $0.isKeyWindow }
    
    var height = UIScreen.main.bounds.height
    var heightConstraint: NSLayoutConstraint?
    var constantTimerValue: Int = 0
    var timer: Timer?
    var time = 60{
        didSet{
            timerLabel.text = "\(time)"
        }
    }
    
    var callBack: (() -> Void)?
    //MARK: - Views
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(368)
        label.text = "\(constantTimerValue)"
        label.textColor = .white
        label.alpha = 0.32
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backgroundTimerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "timerOrange")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = UIFont.bold(82)
        label.numberOfLines = 5
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ПРОПУСТИТЬ", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.semiBold(28)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(skipButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let correctButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ПРАВИЛЬНО", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.7559316158, blue: 0.1192589924, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.semiBold(28)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(correctButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [skipButton, correctButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var rightButtonItem: UIBarButtonItem = {
        let rightButtonItem = UIBarButtonItem(title: "\(gameDataModel.selectedTeam?.guessedWords ?? 0)/60", style: .done, target: nil, action: nil)
        rightButtonItem.tintColor = .black
        rightButtonItem.setTitleTextAttributes([.font: UIFont.bold(38)], for: .disabled)
        rightButtonItem.isEnabled = false
        return rightButtonItem
    }()
    
    // ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        setupConstraints()
        disableSwipeToPop()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        getWord()
    }
    
    func setupView(){
        title = "Команда \(gameDataModel.selectedTeam?.name ?? "")"
        view.backgroundColor = UIColor(named: "orange")
        view.addSubview(backgroundTimerView)
        view.addSubview(timerLabel)
        view.addSubview(wordLabel)
        view.addSubview(buttonStack)
    }
    
    func setupNavigationBar(){
        let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        leftButton.setBackgroundImage(UIImage(named: "pause-button"), for: .normal)
        leftButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        leftButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let leftButtonItem = UIBarButtonItem(customView: leftButton)
        
        navigationItem.leftBarButtonItem = leftButtonItem
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    func setupConstraints(){
        backgroundTimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundTimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundTimerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        heightConstraint = backgroundTimerView.heightAnchor.constraint(equalToConstant: height)
        heightConstraint?.isActive = true
        
        timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        wordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        wordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        wordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        buttonStack.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    func getWord(){
        gameDataModel.getRandomWord()
        wordLabel.text = gameDataModel.currentWord
    }
    
    func animateWordLabel(){
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.wordLabel.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
            self?.wordLabel.alpha = 0.05
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){ [weak self] in
            UIView.animate(withDuration: 0.1) {
                self?.wordLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
                self?.wordLabel.alpha = 1
            }
        }
    }
    
    // Actions
    @objc
    func closeButtonAction(){
        timer?.invalidate()
        
        if let window = windowApp{
            window.frame = UIScreen.main.bounds
            UIView.animate(withDuration: 0.4) {
                let customAlert = CustomPauseAlertView(frame: window.frame)
                customAlert.delegate = self
                window.addSubview(customAlert)
            }
        }
    }
    
    func reloadData(){
        height = CGFloat(UIScreen.main.bounds.height)
        heightConstraint?.constant = height
        time = gameDataModel.time
        title = "Команда \(gameDataModel.selectedTeam?.name ?? "")"
        rightButtonItem.title = "\(gameDataModel.selectedTeam?.guessedWords ?? 0)/60"
    }
    
    @objc
    func tick(){
        time -= 1
        height -= CGFloat(UIScreen.main.bounds.height / CGFloat(constantTimerValue))
        heightConstraint?.constant = height
        
        if time == 0{
            timer?.invalidate()

            if gameDataModel.currentRound != gameDataModel.teams.count{
                let endRoundVC = EndRoundViewController()
                endRoundVC.gameDataModel = gameDataModel
                endRoundVC.callBack = {
                    self.reloadData()
                }
                endRoundVC.modalPresentationStyle = .fullScreen
                present(endRoundVC, animated: true, completion: nil)
            } else {
                //view with results
                print("End game")
            }
        }
    }
    
    @objc
    func correctButtonAction(){
        audioPlayer.playSound("right")
        animateWordLabel()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {[weak self] in
            guard let self = self else { return }
            self.gameDataModel.addPoint()
            self.rightButtonItem.title = "\(self.gameDataModel.selectedTeam?.guessedWords ?? 0)/60"
            self.wordLabel.text = self.gameDataModel.currentWord
        }
    }
    
    @objc
    func skipButtonAction(){
        audioPlayer.playSound("wron")
        animateWordLabel()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {[weak self] in
            guard let self = self else { return }
            self.gameDataModel.removePoint()
            self.wordLabel.text = self.gameDataModel.currentWord
        }
    }
}

extension GameViewController: CustomPauseAlertViewDelegate{
    func continueButtonPress(_ view: UIView) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        removeCustomAlertView()
    }
    
    func resetButtonPress(_ view: UIView) {
        time = gameDataModel.time
        gameDataModel.resetGame()
        reloadData()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        removeCustomAlertView()
    }
    
    func exitButtonPress(_ view: UIView) {
        gameDataModel.resetGame()
        removeCustomAlertView()
        navigationController?.popViewController(animated: true)
        callBack?()
    }
    
    func removeCustomAlertView(){
        if let window = self.windowApp{
            for subview in window.subviews{
                if subview is CustomPauseAlertView{
                    subview.removeFromSuperview()
                }
            }
        }
    }
}

extension GameViewController{
    func disableSwipeToPop(){
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}
