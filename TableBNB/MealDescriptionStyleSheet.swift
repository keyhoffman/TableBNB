//
//  MealDescriptionStyleSheet.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/26/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import PopupDialog

enum MealDescriptionStyleSheet: ViewPreparer {

    static func prepare(subject: PopupDialog<UIViewController>) {
        
        subject.transitionStyle = .ZoomIn
        
        let pv = PopupDialogDefaultView.appearance()
        pv.titleFont    = Theme.Title.font
        pv.titleColor   = Color.White.color
        pv.messageFont  = Theme.Body.font
        pv.messageColor = Color.WhiteGrayScale08.color
        
        let pcv = PopupDialogContainerView.appearance()
        pcv.backgroundColor = Color.DarkGray.color
        pcv.cornerRadius    = 2
        pcv.shadowEnabled   = true
        pcv.shadowColor     = Color.Black.color
    
        let ov = PopupDialogOverlayView.appearance()
        ov.blurEnabled = true
        ov.blurRadius  = 50
        ov.liveBlur    = true
        ov.opacity     = 0.7
        ov.color       = Color.Black.color
    }
}


//
//
//        // Customize default button appearance
//        let db = DefaultButton.appearance()
//        db.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
//        db.titleColor     = UIColor.whiteColor()
//        db.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
//        db.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)
//
//        // Customize cancel button appearance
//        let cb = CancelButton.appearance()
//        cb.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
//        cb.titleColor     = UIColor(white: 0.6, alpha: 1)
//        cb.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
//        cb.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)
//
