//
//  ToDoDetailViewController.swift
//  ToDoList
//
//  Created by Serguei Diaz on 06.04.2025.
//

import UIKit

class DefaultToDoDetailViewController: UIViewController, UITextViewDelegate, ToDoDetailViewControllerProtocol {
    
    let presenter: ToDoDetailPresenterProtocol
    
    var toDo: ToDoEntity?
    
    init(presenter: ToDoDetailPresenterProtocol, toDo: ToDoEntity? = nil) {
        self.presenter = presenter
        self.toDo = toDo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupLayout()
    }
    
    let verticalStack: UIStackView = {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.spacing = 4
        
        return verticalStack
    }()
    
    private let titleField: UITextField = {
        let titleField = UITextField()
        titleField.placeholder = "Введите заголовок"
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.font = UIFont.boldSystemFont(ofSize: 34)
        return titleField
    }()
    
    private let descriptionTextView: UITextView = {
        let descriptionTextView = UITextView()
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        return descriptionTextView
    }()
    
    private func saveIfPossible() {
        guard let title = titleField.text,
                let description = descriptionTextView.text,
              !title.isEmpty,
                !description.isEmpty
        else { return }
        
        presenter.saveToDo(toDo: .init(
            id: toDo?.id,
            title: title,
            description: description,
            date: toDo?.date,
            isDone: toDo?.isDone ?? false)
        )
    }
    
    func textViewDidChange(_ textView: UITextView) {
        saveIfPossible()
    }
    
    @objc private func titleChanged(_ sender: UITextField) {
        saveIfPossible()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        titleField.addTarget(self, action: #selector(titleChanged), for: .editingChanged)
        descriptionTextView.delegate = self
        
        titleField.text = toDo?.title
        descriptionTextView.text = toDo?.description
                        
        verticalStack.addArrangedSubview(titleField)
        verticalStack.addArrangedSubview(descriptionTextView)
        
        view.addSubview(verticalStack)
    }
    
    private func setupLayout() {
        
        let safe = view.safeAreaLayoutGuide
        
        let inset = 20.0
        
        NSLayoutConstraint.activate([
            verticalStack.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: inset),
            verticalStack.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -inset),
            verticalStack.topAnchor.constraint(equalTo: safe.topAnchor, constant: inset),
            verticalStack.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -inset),
        ])
    }    
}

extension DefaultToDoDetailViewController {
    func showError(_ message: String) {
        let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
