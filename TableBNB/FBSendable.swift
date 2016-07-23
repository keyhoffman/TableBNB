//
//  FBSendable.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/19/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import Firebase

// MARK: - FirebaseSendable Protocol

protocol FBSendable: FBType, Equatable {
    var key: String { get }
    
    static var NeedsAutoKey: Bool        { get }
    static var FBSubKeys:   [String]     { get }
    
    static func Create(FBDict: FBDictionary?) -> Result<Self>
}

// MARK: - FirebaseSendable Protocol Extension

extension FBSendable {
    
    private var sendingError: NSError { // TODO: Move this elsewhere
        return NSError(domain: "TableBNB", code: 1, userInfo: [NSLocalizedDescriptionKey: "Could not convert \(Self.self) to FBDictionary"])
    }
    
    static var instantiationError: NSError {
        return NSError(domain: "TableBNB", code: 2, userInfo: [NSLocalizedDescriptionKey: "Could not instantiate \(Self.self)"])
    }
    
    func sendToFB(withResult: Result<Self> -> Void) {
        guard let FBDict = convertToFBSendable() else {
            withResult(.Failure(sendingError))
            return
        }
        FBDict.dump_()
        let path = Self.NeedsAutoKey ? Self.Path + autoKey : Self.Path + key
        print("path = \(path)")
        Self.RootRef.child(path).setValue(FBDict) { error, _ in
            if let error = error {
                withResult(.Failure(error))
                return
            }
            withResult(.Success(self))
        }
    }
    
    private var autoKey: String { return Self.RootRef.childByAutoId().key }
    
    private func convertToFBSendable() -> FBDictionary? {
        var FBDict: FBDictionary = [:]
        let mirror = Mirror(reflecting: self)
        for case let (label?, value) in mirror.children {
            print("label = \(label), value = \(value)")
            print("value subjectType = \(Mirror(reflecting: value).subjectType)")
            FBDict[label] = value as? AnyObject
        }
        return Dictionary(FBDict.filter { Self.FBSubKeys.contains($0.0) })
    }
}

extension FBSendable {
    static func loadChildAdded(withBlock: Result<Self> -> Void) {
        observe(withEventType: .ChildAdded) { withBlock($0) }
    }
    
    //    static func loadValue(withKey key: String, withBlock: Result<Self> -> Void) {
    //        observe(withEventType: .Value) { withBlock($0) }
    //    }
    
    private static var snapshotError: NSError { // TODO: Move elsewhere
        return NSError(domain: "TableBNB", code: 3, userInfo: [NSLocalizedDescriptionKey: "Could not convert snapshot to type \(Self.self)"])
    }
    
    private static func observe(withEventType event: FIRDataEventType, withBlock: Result<Self> -> Void) {
        //        let path = event == .Value ? Path : Path + ""
        Self.RootRef.child(Path).observeEventType(event, withBlock: { (snapshot: FIRDataSnapshot) in
            guard var FBDict = snapshot.value as? FBDictionary else { // TODO: Is it okay to make FBDict mutable?
                print("Resource loading fail")
                withBlock(.Failure(self.snapshotError))
                return
            }
            FBDict["key"] = snapshot.key
            withBlock(Self.Create(FBDict))
            return
        }) { error in
            withBlock(.Failure(error))
            return
        }
    }
}

