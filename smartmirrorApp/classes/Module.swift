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
    var dataToPass : [String:Any] {
        return [
            "config" : self.config,
            "module" : self.module,
            "name" : self.name,
            "position" : self.position.dataToPass,
            "size" : self.size.dataToPass
        ]
    }
    
    init(config: [String: String], module: String, name:String, position: Position, size: Size) {
        self.config = config
        self.module = module
        self.name = name
        self.position = position
        self.size = size
    }
    
    static func modulesDataToSend(modules: Array<Module>) -> [[String:Any]] {
        var mods: [[String:Any]] = []
        for module in modules{
            mods.append(module.dataToPass)
        }
        
        return mods
    }
}
