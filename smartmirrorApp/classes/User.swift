//
//  user.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 21/10/2022.
// https://peterfriese.dev/posts/firestore-codable-the-comprehensive-guide/

import Foundation
import FirebaseFirestoreSwift

class User:Codable{
    @DocumentID var id: String?
    var name: String
    var pinCode: String
    var module: Array<Module>;
    var img: String?
    var imageFRurl: String?
    var dataToPass : [String:Any] {
        return [
            "name" : self.name,
            "pinCode" : self.pinCode,
            "module" : self.module,
        ]
    }
    init(id: String? = nil, name: String, pinCode: String, img: String) {
        self.id = id
        self.name = name
        self.pinCode = pinCode
        self.module = Array()
        self.img = img
    }
    
    
    func addModule(config: [String: String], module: String, name: String, position: Position, size: Size){
        self.module.append(Module(config: config, module: module,name: name, position: position, size: size))
    }
}
