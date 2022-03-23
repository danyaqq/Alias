//
//  MainViewController.swift
//  Alias
//
//  Created by Даня on 21.02.2022.
//

import UIKit

class MainViewController: UIViewController {
    
//MARK: - Views
    
    lazy var backgorundImage: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "bg"))
        imageView.frame = view.bounds
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ALIAS\nGAME"
        label.font = UIFont.bold(92)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .white
        label.spacing = 0
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("НАЧАТЬ ИГРУ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.bold(32)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(startAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var topStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, startButton])
        stack.spacing = 20
        stack.axis = .vertical
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let howToPlayButton: UIButton = {
        let image = UIImage(systemName: "questionmark.square")
        let title = "КАК ИГРАТЬ?"
        
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.semiBold(24)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.imageEdgeInsets = .init(top: 0, left: -8, bottom: 0, right: 0)
        button.titleEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(howToPlayAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupContraints()
        swipeToPop()
    }

    //View setup
    private func setupView(){
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(backgorundImage)
        view.addSubview(topStackView)
        view.addSubview(howToPlayButton)
    }
    
    //Constraints
    private func setupContraints(){
        topStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        startButton.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor, constant: 40).isActive = true
        startButton.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor, constant: -40).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        howToPlayButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        howToPlayButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        howToPlayButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        howToPlayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    //Actions
    @objc
    func howToPlayAction(_ sender: UIButton){
        let howToPlayVC = HowToPlayViewController()
        navigationController?.pushViewController(howToPlayVC, animated: true)
    }
    
    @objc
    func startAction(_ sender: UIButton){
        let teamsVC = TeamsViewController()
        navigationController?.pushViewController(teamsVC, animated: true)
    }
    
//    //Get joke from API
//    func fetchJoke(){
//        NetworkManager.shared.getData(url: Constants.baseURL) { [weak self] joke in
//            DispatchQueue.main.async {
//                self?.joke = joke
//            }
//        }
//    }
}

//MARK: - Swipe to pop extension
extension MainViewController{
    func swipeToPop(){
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
}
