//
//  Result.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/19/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation

// TODO: Keep this handy

//protocol Mappable {
//    associatedtype Element
//    func map<OutType>(transform: Element -> OutType) -> Self
//}

enum Result<T> {
    typealias Value = T
    
    case Success(Value)
    case Failure(ErrorType)
}
