//
//  Size.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 27/10/2022.
//

import Foundation

class Size :Codable{
    var height: Int
    var width: Int
    var dataToPass : [String:Any] {
        return [
            "height" : self.height,
            "width" : self.width
        ]
    }
    
    init(height: Int, width: Int) {
        self.height = height
        self.width = width
    }
}
