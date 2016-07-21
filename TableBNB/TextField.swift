//
//  TextField.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UITextField Extension

extension UITextField { 
    func clearText() {
        self.text = ""
    }
    
    func defaultSettings() {
        self.adjustsFontSizeToFitWidth = true
        self.autocapitalizationType    = .None
        self.autocorrectionType        = .No
        self.clearButtonMode           = .Always
        self.keyboardAppearance        = .Dark
        self.keyboardType              = .Default
    }
}