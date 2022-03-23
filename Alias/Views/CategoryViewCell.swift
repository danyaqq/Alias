//
//  CategoryViewCell.swift
//  Alias
//
//  Created by Даня on 22.02.2022.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryViewCell"

    lazy var categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 6
        view.layer.borderColor = #colorLiteral(red: 0.9795191884, green: 0.9780929685, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Категория"
        label.font = UIFont.semiBold(28)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "turle")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "Количество: 2"
        label.font = UIFont.regular(19)
        label.textColor = .systemGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
        setupConstraints()
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                categoryView.layer.borderWidth = 6
                categoryView.layer.cornerRadius = 12
                categoryView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            } else {
                categoryView.layer.cornerRadius = 12
                categoryView.layer.borderWidth = 6
                categoryView.layer.borderColor = #colorLiteral(red: 0.9795191884, green: 0.9780929685, blue: 1, alpha: 1)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupViews(){
        addSubview(categoryView)
        
        categoryView.addSubview(titleLabel)
        categoryView.addSubview(imageView)
        categoryView.addSubview(countLabel)
    }
    
    func setupConstraints(){
        titleLabel.topAnchor.constraint(equalTo: categoryView.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: categoryView.centerXAnchor).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: categoryView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: categoryView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 52).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        countLabel.bottomAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: -10).isActive = true
        countLabel.centerXAnchor.constraint(equalTo: categoryView.centerXAnchor).isActive = true
        
        categoryView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        categoryView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    func configure(with category: Category){
        titleLabel.text = category.name
        imageView.image = UIImage(named: category.image)
        countLabel.text = "Количество: \(category.words.count)"
    }
    
}
