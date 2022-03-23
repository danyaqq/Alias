//
//  CustomAlertWithJoke.swift
//  Alias
//
//  Created by Даня on 25.02.2022.
//

import Foundation
import UIKit

class CustomAlertWithJoke: UIView {

    var placeholder: String? = nil
    
    //MARK: - Views
    let mainView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    let titleAlert: UILabel = {
        let label = UILabel()
        label.text = "Шутка!"
        label.font = UIFont.semiBold(32)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var messageAlert: UILabel = {
        let label = UILabel()
        label.text = placeholder
        label.font = UIFont.semiBold(28)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ОК", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.semiBold(28)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(continueButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleAlert, messageAlert, continueButton])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        stack.distribution = .fill
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

        addSubview(mainView)
        mainView.addSubview(stackView)
        
        messageAlert.text = placeholder
    }
    
    func setupConstraints(){
        mainView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mainView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 60).isActive = true
        stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -60).isActive = true
        stackView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        
        continueButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func animateAlpha(with alpha: Double){
        UIView.animate(withDuration: 0.4) {[weak self] in
            self?.alpha = alpha
        }
    }
    
    func removeCustomAlertView(){
        removeFromSuperview()
    }
    
    //MARK: - Actions
    @objc
    func continueButtonAction(){
        animateAlpha(with: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            guard let self = self else { return }
            self.removeCustomAlertView()
            
        }
    }
    
}
