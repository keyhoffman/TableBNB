//
//  Resource.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - Resource

struct Resource<R: FBSendable>: FBObservable {
    static var Path: String { return R.Path + "/" }
    let parse: FBDictionary? -> Result<R>
}
