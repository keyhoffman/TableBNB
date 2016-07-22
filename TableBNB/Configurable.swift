//
//  Configurable.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - Configurable Protocol

protocol Configurable {
    associatedtype DataType: Any
    func configure(withItem item: DataType)
}