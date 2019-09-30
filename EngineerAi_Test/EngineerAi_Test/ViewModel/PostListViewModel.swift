//
//  PostListViewModel.swift
//  EngineerAi_Test
//
//  Created by Александр  on 9/30/19.
//  Copyright © 2019 GoToInc. All rights reserved.
//

import Foundation



class PostListViewModel: ListViewModel {
    private var postListModel: PostListModel
    
    init(postListModel: PostListModel){
        self.postListModel = postListModel
        super.init(model: postListModel)
    }
    
    
    
}

class PostListModel: ListModel {
  
    var page: Int
 
    override func getItems() {
         getpageList(page: page)
    }
    
    init(page: Int) {
        self.page = page
        super.init()
    }
    
    private func getpageList(page: Int) {
        dataManager.fetchPosts(with: page) { [weak self] (result) in
            switch result {
            case .success(let responce):
                print(responce)
                
                responce.results.forEach{ self?.items.append($0)}
            case .failure(let err):
                print(err)
                self?.handleError?(err)
                
            }
        }
    }
    
   
   
    
}
