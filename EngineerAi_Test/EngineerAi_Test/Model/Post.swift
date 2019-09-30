//
//  Post.swift
//  EngineerAi_Test
//
//  Created by Александр  on 9/30/19.
//  Copyright © 2019 GoToInc. All rights reserved.
//

import Foundation

public struct Post: Codable {
       
    public let objectID: Int
    public let title: String
    public let createAt: Date
    var isActive = false
      
   }

