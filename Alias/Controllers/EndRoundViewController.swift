//
//  EndRoundViewController.swift
//  Alias
//
//  Created by Даня on 25.02.2022.
//

import UIKit

class EndRoundViewController: UIViewController {
    
    var gameDataModel: AliasDataModel? = nil
    var callBack: (() -> ())? = nil
    
    lazy var endRoundView: EndRoundView = {
        let view = EndRoundView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView(){
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(endRoundView)
        showAlertWithJoke()
    }
    
    func setupConstraints(){
        endRoundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        endRoundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        endRoundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        endRoundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func showAlertWithJoke(){
        
        JokeManager.shared.getData { joke in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.4) { [weak self] in
                    let customAlert = CustomAlertWithJoke(frame: UIScreen.main.bounds)
                    customAlert.placeholder = joke.value
                    self?.view.addSubview(customAlert)
                }
            }
        }
        
    }
    
}

extension EndRoundViewController: EndRoundViewDelegate{
    func startButtonTap() {
        dismiss(animated: true) { [weak self] in
            self?.gameDataModel?.changeSelectedTeam()
            self?.callBack?()
        }
    }
}
