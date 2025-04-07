//
//  ToDoCellView.swift
//  ToDoList
//
//  Created by Serguei Diaz on 05.04.2025.
//

import UIKit

class ToDoCellView: UITableViewCell {
    
    static let identifier = "ToDoCell"

    private let checkmarkView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 1
        return titleLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textColor = .secondaryLabel
        return descriptionLabel
    }()
    
    private let verticalStack: UIStackView = {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.alignment = .leading
        verticalStack.spacing = 4
        
        return verticalStack
    }()
    
    private let horizontalStack: UIStackView = {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .top
        horizontalStack.spacing = 8
        
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        return horizontalStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        backgroundColor = .clear

        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(descriptionLabel)
        
        horizontalStack.addArrangedSubview(checkmarkView)
        horizontalStack.addArrangedSubview(verticalStack)
        
        contentView.addSubview(horizontalStack)
        
    }
    
    private func setupLayout() {
        
        let inset = 12.0
                
        NSLayoutConstraint.activate([
            //checkmarkView.widthAnchor.constraint(equalToConstant: 24),
            //checkmarkView.heightAnchor.constraint(equalToConstant: 24),
            
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
    
    func configure(title: String, description: String, isDone: Bool) {
        
        checkmarkView.image = UIImage(systemName: isDone ? "checkmark.circle" : "circle")
        
        checkmarkView.tintColor = isDone ? .systemYellow : .systemFill
        
        let attributedString = NSAttributedString(
            string: title,
            attributes: isDone ? [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue
            ] : [:]
        )
        
        titleLabel.textColor = isDone ? .secondaryLabel : .label
        descriptionLabel.textColor = isDone ? .secondaryLabel : .label
        
        descriptionLabel.text = description
        titleLabel.attributedText = attributedString
    }
        
    func setLongPressStyle() {
        
        UIView.animate(withDuration: 1) { [weak self] in
            self?.contentView.backgroundColor = .secondarySystemBackground
            self?.contentView.layer.cornerRadius = 12
        }
                
        horizontalStack.removeArrangedSubview(checkmarkView)
        checkmarkView.removeFromSuperview()
    }
    
    func removeLongPressStyle() {
        
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 0
        
        horizontalStack.insertArrangedSubview(checkmarkView, at: 0)
    }
}
