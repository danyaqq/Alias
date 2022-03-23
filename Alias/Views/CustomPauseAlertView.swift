//
//  CustomPauseAlertView.swift
//  Alias
//
//  Created by Даня on 24.02.2022.
//

import Foundation
import UIKit

protocol CustomPauseAlertViewDelegate: AnyObject{
    func continueButtonPress(_ view: UIView)
    func resetButtonPress(_ view: UIView)
    func exitButtonPress(_ view: UIView)
}

class CustomPauseAlertView: UIView{
    
    //MARK: - Properties
    weak var delegate: CustomPauseAlertViewDelegate?
    
    //MARK: - Views
    let mainView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleAlert: UILabel = {
        let label = UILabel()
        label.text = "Пауза"
        label.font = UIFont.semiBold(32)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.semiBold(28)
        button.backgroundColor = UIColor(named: "background")
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(continueButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сбросить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.semiBold(28)
        button.backgroundColor = UIColor(named: "timerOrange")
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(resetButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.semiBold(28)
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(exitButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [continueButton, resetButton, exitButton])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 20
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleAlert, buttonStack])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        stack.distribution = .fillProportionally
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
        setupConstraints()
    }
    
    func setupView(){
        alpha = 0
        animateAlpha(with: 1)
        
        containerView.addSubview(stackView)
        mainView.addSubview(containerView)
        addSubview(mainView)
    }
    
    func setupConstraints(){
        containerView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 30).isActive = true
        containerView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -30).isActive = true
        containerView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 1.65/4).isActive = true
        containerView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive = true
        
        buttonStack.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30).isActive = true
        buttonStack.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30).isActive = true
    }
    
    func animateAlpha(with alpha: Double){
        UIView.animate(withDuration: 0.4) {[weak self] in
            self?.alpha = alpha
        }
    }
    
    //MARK: - Actions
    @objc
    func continueButtonAction(){
        animateAlpha(with: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            guard let self = self else { return }
            self.delegate?.continueButtonPress(self)
        }
    }
    
    @objc
    func resetButtonAction(){
        animateAlpha(with: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            guard let self = self else { return }
            self.delegate?.resetButtonPress(self)
        }
    }
    
    @objc
    func exitButtonAction(){
        animateAlpha(with: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            guard let self = self else { return }
            self.delegate?.exitButtonPress(self)
        }
    }
}
