//
//  GetMainThread.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/20/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation

func performUpdatesOnMain(updates: Void -> Void) {
    dispatch_async(dispatch_get_main_queue()) {
        updates()
    }
}