//
//  Dumpable.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/19/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation

protocol Dumpable {}

extension Dumpable {
    func dump_() {
        let mirror = Mirror(reflecting: self)
        print("----- \(mirror.description): \(Self.self) Dump -----")
        dump(self)
    }
    
    func dump_(withContext context: String) {
        print("----- \(context) -----")
        dump_()
    }
    
}

extension Dictionary: Dumpable {}

extension String: Dumpable {}

extension Bool: Dumpable {}