//
//  Result.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/19/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation

enum Result<T> {
    typealias Value = T
    
    case Success(Value)
    case Failure(ErrorType)
}