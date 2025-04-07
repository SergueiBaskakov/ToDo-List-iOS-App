//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by Serguei Diaz on 03.04.2025.
//

import UIKit

class DefaultToDoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, ToDoListViewControllerProtocol {
    
    let presenter: ToDoListPresenterProtocol
    
    private var data: [ToDoEntity] = []
    
    private var contextMenuIndexPath: IndexPath?
    
    private typealias ToDoTableCellType = ToDoCellView
    
    init(presenter: ToDoListPresenterProtocol) {
        self.presenter = presenter
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
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.getToDoList()
    }
    
    private let verticalStack: UIStackView = {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        return verticalStack
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let bottomBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let taskCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "square.and.pencil")
        button.setImage(image, for: .normal)
        button.tintColor = .systemYellow
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let backgroundBelowBar: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc private func addButtonTapped() {
        presenter.newToDo()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            presenter.getToDoList()
        }
        else {
            presenter.getFilteredToDoList(searchText)
        }
    }
    
    private func setupViews() {
        
        view.backgroundColor = .systemBackground
        title = "Задачи"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        
        searchBar.delegate = self
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ToDoTableCellType.self, forCellReuseIdentifier: ToDoTableCellType.identifier)
        
        bottomBar.addSubview(taskCountLabel)
        bottomBar.addSubview(addButton)
        
        taskCountLabel.text = "\(data.count) Задач"
        
        verticalStack.addArrangedSubview(searchBar)
        verticalStack.addArrangedSubview(tableView)
        verticalStack.addArrangedSubview(bottomBar)
        
        view.addSubview(verticalStack)
        view.addSubview(backgroundBelowBar)
    }
    
    private func setupLayout() {
        
        let safe = view.safeAreaLayoutGuide
        
        let inset = 0.0
        
        NSLayoutConstraint.activate([
            
            bottomBar.heightAnchor.constraint(equalToConstant: 50),
            
            verticalStack.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: inset),
            verticalStack.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -inset),
            verticalStack.topAnchor.constraint(equalTo: safe.topAnchor, constant: inset),
            verticalStack.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -inset),
            
            taskCountLabel.centerYAnchor.constraint(equalTo: bottomBar.centerYAnchor),
            taskCountLabel.centerXAnchor.constraint(equalTo: bottomBar.centerXAnchor),
            
            addButton.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -16),
            addButton.centerYAnchor.constraint(equalTo: bottomBar.centerYAnchor),
            
            backgroundBelowBar.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            backgroundBelowBar.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            backgroundBelowBar.topAnchor.constraint(equalTo: bottomBar.bottomAnchor),
            backgroundBelowBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension DefaultToDoListViewController {
    func showError(_ message: String) {
        let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func showToDoList(_ toDoList: [ToDoEntity]) {
        data = toDoList
        updateTableView()
    }
    
    func changeToDoStatus(_ toDo: ToDoEntity) {
        if let index = data.firstIndex(where: { $0.id == toDo.id }) {
            data[index] = toDo
            updateTableRow(index: index)
        }
    }
    
    func deleteToDo(_ toDoId: String) {
        if let indexPath = contextMenuIndexPath,
           let cell = tableView.cellForRow(at: indexPath) as? ToDoTableCellType {
            cell.removeLongPressStyle()
            contextMenuIndexPath = nil
        }
        
        if let index = data.firstIndex(where: { $0.id == toDoId }) {
            removeRowFromTable(index: index)
        }
    }
    
    private func updateTableView() {
        tableView.reloadData()
        taskCountLabel.text = "\(data.count) Задач"
    }
    
    private func removeRowFromTable(index: Int) {
        data.remove(at: index)
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
        taskCountLabel.text = "\(data.count) Задач"
    }
    
    private func updateTableRow(index: Int) {
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}

extension DefaultToDoListViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let toDo = data[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableCellType.identifier, for: indexPath) as? ToDoTableCellType else {
            return UITableViewCell()
        }
        
        cell.configure(
            title: toDo.title,
            description: toDo.description,
            isDone: toDo.isDone
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? ToDoTableCellType else { return nil }
        
        cell.setLongPressStyle()
        
        contextMenuIndexPath = indexPath
        
        let toDo = data[indexPath.row]
        
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let edit = UIAction(title: "Редактировать", image: UIImage(systemName: "square.and.pencil")) { [weak self] _ in
                self?.presenter.goToDetailToDo(toDo)
                print("Edit tapped")
            }
            let share = UIAction(title: "Поделиться", image: UIImage(systemName: "square.and.arrow.up")) { [weak self] _ in

                let shareText = "ToDo: \(toDo.title)\nDescription: \(toDo.description)"
                
                let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
                
                self?.present(activityVC, animated: true, completion: nil)
                print("Share tapped")
            }
            let delete = UIAction(title: "Удалить", image: UIImage(systemName: "trash"), attributes: .destructive) { [weak self] _ in
                self?.presenter.deleteToDo(toDo)
                print("Delete tapped")
            }
            
            return UIMenu(title: "", children: [edit, share, delete])
        }
    }
    
    func tableView(_ tableView: UITableView, willEndContextMenuInteraction configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        
        if let indexPath = contextMenuIndexPath,
           let cell = tableView.cellForRow(at: indexPath) as? ToDoTableCellType {
            
            cell.removeLongPressStyle()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let toDo = data[indexPath.row]
        
        presenter.changeToDoStatus(toDo)
        
    }
}

