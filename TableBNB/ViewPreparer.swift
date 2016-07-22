//
//  ViewPreparer.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/22/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: ViewPreparer Protocol

protocol ViewPreparer {
    associatedtype ViewType: Any
    static func prepare(subject: ViewType)
}