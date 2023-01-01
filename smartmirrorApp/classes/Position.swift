//
//  Position.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 27/10/2022.
//

import Foundation

class Position :Codable{
    var x: Int
    var y: Int
    var dataToPass : [String:Any] {
        return [
            "x" : self.x,
            "y" : self.y
        ]
    }
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}
