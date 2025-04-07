//
//  ToDoListPresenter.swift
//  ToDoList
//
//  Created by Serguei Diaz on 03.04.2025.
//

class DefaultToDoListPresenter: ToDoListPresenterProtocol {

    weak var view: ToDoListViewControllerProtocol?
    
    var getToDoListInteractor: GetToDoListUseCase
    
    var deleteToDoInteractor: DeleteToDoUseCase
    
    var changeToDoStatusInteractor: ChangeToDoStatusUseCase
    
    let router: ToDoListRouterProtocol?
    
    init(view: ToDoListViewControllerProtocol? = nil, getToDoListInteractor: GetToDoListUseCase, deleteToDoInteractor: DeleteToDoUseCase, changeToDoStatusInteractor: ChangeToDoStatusUseCase, router: ToDoListRouterProtocol?) {
        self.view = view
        self.getToDoListInteractor = getToDoListInteractor
        self.deleteToDoInteractor = deleteToDoInteractor
        self.changeToDoStatusInteractor = changeToDoStatusInteractor
        self.router = router
    }
        
    func onReceiveToDoListSuccess(_ toDoList: [ToDoEntity]) {
        view?.showToDoList(toDoList)
    }
    
    func onReceiveToDoListError(_ error: Error) {
        print(error)
        view?.showError("Ошибка при получении списка")
    }
        
    func onChangeToDoStatusSuccess(_ toDo: ToDoEntity) {
        view?.changeToDoStatus(toDo)
    }
    
    func onChangeToDoStatusError(_ error: Error) {
        print(error)
        view?.showError("Ошибка при изменении статуса")
    }
    
    func onDeleteToDoSuccess(_ toDo: ToDoEntity?, removedToDoId: String?) {
        guard let removedToDoId else { return }
        
        view?.deleteToDo(removedToDoId)
    }
    
    func onDeleteToDoError(_ error: Error) {
        print(error)
        view?.showError("Ошибка при удалении")
    }
    
    func deleteToDo(_ toDo: ToDoEntity) {
        deleteToDoInteractor.deleteToDo(toDo)
    }
    
    func changeToDoStatus(_ toDo: ToDoEntity) {
        changeToDoStatusInteractor.changeToDoStatus(toDo)
    }
    
    func getToDoList() {
        getToDoListInteractor.getToDoList()
    }
    
    func getFilteredToDoList(_ filter: String) {
        getToDoListInteractor.getFilteredToDoList(filter)
    }
    
    func newToDo() {
        
        guard let view = view else { return }
        
        router?.goToNewToDo(from: view)
    }
    
    func goToDetailToDo(_ toDo: ToDoEntity) {
        
        guard let view = view else { return }

        router?.goToDetail(from: view, for: toDo)
        
    }
    
}
