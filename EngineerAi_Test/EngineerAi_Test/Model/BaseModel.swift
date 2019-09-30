//
//  BaseModel.swift
//  EngineerAi_Test
//
//  Created by Александр  on 9/30/19.
//  Copyright © 2019 GoToInc. All rights reserved.
//

import Foundation


protocol Model {
    var didUpdate: (() -> Void)? {get set}
    var handleError: ((Error) -> Void)? {get set}
    var dataManager: ApiManager {get set}
}

class BaseModel: Model {
    var didUpdate: (() -> Void)?
    var handleError: ((Error) -> Void)?
    var dataManager: ApiManager = ApiManager.shared
    init(){}
    
    init(dataManager: ApiManager) {
        self.dataManager = dataManager
    }
    
}



