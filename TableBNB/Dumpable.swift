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
        print("----- \(Self.self) Dump -----")
        dump(self)
    }
    
    func dumpWithContext(context: String) {
        print("----- \(context) -----")
        dump_()
    }
}

extension Dictionary: Dumpable {}