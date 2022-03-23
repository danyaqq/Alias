//
//  TeamTableViewCell.swift
//  Alias
//
//  Created by Даня on 24.02.2022.
//

import UIKit

protocol TeamTableViewCellDelegate: AnyObject{
    func deleteButtonTap(index: Int)
}

class TeamTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "TeamTableViewCell"
    
    weak var delegate: TeamTableViewCellDelegate?
    
    var indexPath: Int? = nil
    //MARK: - View
    private let teamTitle: UILabel = {
        let label = UILabel()
        label.text = "Команда"
        label.font = UIFont.semiBold(26)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let removeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "delete"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.1717935503, green: 0.1715506315, blue: 0.1757325232, alpha: 1)
        button.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        addSubview(teamTitle)
        addSubview(removeButton)
        backgroundColor = .clear
    }
    //MARK: - View setup
    func setupConstraints(){
        teamTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        teamTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40).isActive = true
        teamTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        removeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        removeButton.heightAnchor.constraint(equalToConstant: 23).isActive = true
        removeButton.widthAnchor.constraint(equalToConstant: 23).isActive = true
        removeButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func configure(with title: Team, teams: [Team], index: Int){
        teamTitle.text = title.name
        indexPath = index
        if teams.count <= 2{
            removeButton.isHidden = true
        } else {
            removeButton.isHidden = false
        }
    }
    //MARK: - Actions
    @objc
    func deleteButtonAction(){
        guard let indexPath = indexPath else {
            return
        }

        delegate?.deleteButtonTap(index: indexPath)
    }
    
}
