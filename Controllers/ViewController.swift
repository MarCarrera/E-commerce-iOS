//
//  ViewController.swift
//  E-commerce
//
//  Created by Erick Gámez Sánchez on 06/11/23.
//

import Foundation

class NavigationManager : ObservableObject{
    @Published var selectedItem : Int = 0
    @Published var selectedCategory : Int = 0
}


