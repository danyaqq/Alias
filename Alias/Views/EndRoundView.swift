//
//  EndRoundView.swift
//  Alias
//
//  Created by Даня on 25.02.2022.
//

import UIKit

protocol EndRoundViewDelegate: AnyObject{
    func startButtonTap()
}

class EndRoundView: UIView {

    var teamName: String?
    var nextTeam: String?
    
    weak var delegate: EndRoundViewDelegate?
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ПОЕХАЛИ!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.semiBold(24)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(startButton)
    }
    
    func setupConstraints(){
        startButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        startButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    @objc
    func startButtonAction(){
        delegate?.startButtonTap()
    }
}
