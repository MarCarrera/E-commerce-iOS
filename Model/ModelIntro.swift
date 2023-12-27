//
//  ModelData.swift
//  login
//
//  Created by Erick Gámez Sánchez on 05/12/23.
//

import Foundation
import SwiftUI

struct Intro: Identifiable{
    var id = UUID().uuidString
    var title : String
    var subTitle : String
    var description : String
    var pic : String
    var color : Color
    var offset: CGSize = .zero
}
