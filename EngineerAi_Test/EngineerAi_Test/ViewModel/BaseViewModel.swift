//
//  BaseViewModel.swift
//  EngineerAi_Test
//
//  Created by Александр  on 9/30/19.
//  Copyright © 2019 GoToInc. All rights reserved.
//

import Foundation
class BaseViewModel: ViewModelOutput {
    var showMessage: ((_ message: String) -> Void)?
    var didUpdate: (() -> Void)?
    var isLoading: Bool = false {
        didSet{
            updateLoadingStatus?(isLoading)
        }
    }
    var updateLoadingStatus: ((Bool) -> Void)?
    
}

protocol ViewModelOutput {
    
    var showMessage: ((_ message: String) -> Void)? { get set }
    var didUpdate: (() -> Void)? { get set }
    var isLoading: Bool { get }
    
}


protocol ListViewModelProtocol {
    var itemsCount: Int {get}
    func item(at index: Int) -> Post?
    func loadNext()
  
}




class ListViewModel: BaseViewModel, ListViewModelProtocol {
    var model: ListModel
    var updateItem: ((_ index: Int) -> Void)?
    
    init(model: ListModel){
        self.model = model
        super.init()
        self.model.didUpdate = {[weak self] in
            self?.didUpdate?()
        }
        self.model.getItems()
    }
    var itemsCount: Int {
        return model.itemsCount
    }
    
    func item(at index: Int) -> Post? {
        return model.item(at: index)
    }
    
    func loadNext() {
        model.loadNext()
    }
    
    func updateContent() {
        model.getItems()
    }
    
}

//protocol ListElement {}

protocol ListModelProtocol {
    var itemsCount: Int {get}
    func item(at index: Int) -> Post?
    func loadNext()
}

class ListModel: BaseModel, ListModelProtocol {
    var items: [Post] = [] {
        didSet{
            didUpdate?()
        }
    }
    
    var pageNumber: Int = 1 {
        didSet {
            if oldValue != pageNumber {
                getItems()
            }
        }
    }
    
    var perPage: Int {
        return 20
    }
    
    
    var itemsCount: Int{
        return items.count
    }
    
    func item(at index: Int) -> Post? {
        guard index >= 0 && index < itemsCount else {
            return nil
        }
        return items[index]
    }
    
    func loadNext() {
        pageNumber = items.count / perPage + 1
    }
    
    func getItems() {
        assertionFailure("Must be overriden by inherit")
    }
    
  
}

