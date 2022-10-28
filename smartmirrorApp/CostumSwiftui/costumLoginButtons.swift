//
//  costumLoginButtons.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 25/10/2022.
//

import SwiftUI

struct costumLoginButtons: View {
    var body: some View {
        Button {
            print("Edit button was tapped")
        } label: {
            Image("perfil1")
        }.buttonStyle(.bordered)
    }
}

struct costumLoginButtons_Previews: PreviewProvider {
    static var previews: some View {
        costumLoginButtons()
    }
}
