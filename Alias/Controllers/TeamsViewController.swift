//
//  TeamsViewController.swift
//  Alias
//
//  Created by Даня on 24.02.2022.
//

import UIKit

class TeamsViewController: UIViewController {
    
    //MARK: - Properties
    var teamDataModel = TeamDataModel()
    var gameDataModel = AliasDataModel()
    
    var height = UIScreen.main.bounds.height
    var heightConstraint: NSLayoutConstraint?
    
    //MARK: - Views
    lazy var teamsTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.allowsSelection = false
        table.isScrollEnabled = false
        table.register(TeamTableViewCell.self, forCellReuseIdentifier: TeamTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let addTeamButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.borderWidth = 4
        button.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        
        let imageView = UIImageView(image: UIImage(named: "add"))
        imageView.tintColor = .black
        imageView.frame = .init(x: 17, y: 17, width: 30, height: 30)
        button.addSubview(imageView)
        return button
    }()
    
    private let maxTeamsLabel: UILabel = {
        let label = UILabel()
        label.text = "Максимальное количество\nкоманд в игре - 6"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.regular(24)
        label.textColor = #colorLiteral(red: 0.2390629351, green: 0.2387214899, blue: 0.2445442975, alpha: 1)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ДАЛЕЕ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.semiBold(24)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addItemsToSelectedTeams()
        setupConstraints()
    }
    
    //MARK: - Setup views
    func setupViews(){
        title = "Команды"
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(teamsTable)
        view.addSubview(addTeamButton)
        view.addSubview(maxTeamsLabel)
        view.addSubview(nextButton)
        
        let stopBarButtonItem = UIBarButtonItem(title: "← Назад", style: .done, target: self, action: #selector(dismissButtonAction))
        stopBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = stopBarButtonItem
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.barTintColor = UIColor(named: "background")
        
        height = CGFloat(60 * teamDataModel.teams.count)
    }
    
    func setupConstraints(){
        teamsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        teamsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        teamsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        heightConstraint = teamsTable.heightAnchor.constraint(equalToConstant: height)
        heightConstraint?.isActive = true
        
        addTeamButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addTeamButton.topAnchor.constraint(equalTo: teamsTable.bottomAnchor, constant: 20).isActive = true
        addTeamButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        addTeamButton.widthAnchor.constraint(equalToConstant: 64).isActive = true
        
        maxTeamsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        maxTeamsLabel.topAnchor.constraint(equalTo: teamsTable.bottomAnchor, constant: 20).isActive = true
        
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    //MARK: - Logic
    func addRandomTeamName(){
        teamDataModel.addRandomTeamName()
    }
    
    func addItemsToSelectedTeams(){
        teamDataModel.addItemsToSelectedTeams()
        updateConstraints()
    }
    
    //MARK: - Actions
    @objc
    func dismissButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func nextButtonAction(){
        gameDataModel.teams = teamDataModel.teams

        let startGameVC = StartGameViewController()
        startGameVC.gameDataModel = gameDataModel
        navigationController?.pushViewController(startGameVC, animated: true)
    }
    
    @objc
    func addButtonAction(){
        if teamDataModel.teams.count != 6{
            teamDataModel.addRandomTeamName()
            updateConstraints()
            if teamDataModel.teams.count > 5{
                addTeamButton.isHidden = true
                maxTeamsLabel.isHidden = false
            }
        }
    }
    
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension TeamsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamDataModel.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.identifier, for: indexPath) as? TeamTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: teamDataModel.teams[indexPath.row], teams: teamDataModel.teams, index: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//MARK: - TeamTableViewCellDelegate
extension TeamsViewController: TeamTableViewCellDelegate{
    func deleteButtonTap(index: Int) {
        teamDataModel.removeTeam(index: index)
        addTeamButton.isHidden = false
        maxTeamsLabel.isHidden = true
        updateConstraints()
    }
    
    func updateConstraints(){
        height = CGFloat(60 * teamDataModel.teams.count)
        heightConstraint?.constant = height
        teamsTable.reloadData()
    }
}
