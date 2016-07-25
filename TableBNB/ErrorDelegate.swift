//
//  ErrorDelegate.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/25/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - ErrorDelegate Protocol

protocol ErrorDelegate {
    func anErrorHasOccured(errorMessage: String)
}