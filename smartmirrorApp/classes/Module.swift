//
//  Module.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 27/10/2022.
//

import Foundation

class Module:Codable{
    var config: [String: String]
    var module: String
    var name: String
    var position: Position
    var size: Size
    
    init(config: [String: String], module: String, name:String, position: Position, size: Size) {
        self.config = config
        self.module = module
        self.name = name
        self.position = position
        self.size = size
    }
}
