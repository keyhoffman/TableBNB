//
//  Dumpable.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/19/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Dumpable Protocol

protocol Dumpable {}

// MARK: - Dumpable Protocol Extension

extension Dumpable {
    func dump_() {
        print("----- \(Self.self) Dump -----")
        dump(self)
    }
    
    func dump_(withContext context: String) {
        print("----- \(context) -----")
        dump_()
    }
    
}

// MARK: - Dictionary Extension

extension Dictionary: Dumpable {}

// MARK: - String Extension

extension String: Dumpable {}

// MARK: - Boolean Extension

extension Bool: Dumpable {}

// MARK: UIImage Extension

extension UIImage: Dumpable {}