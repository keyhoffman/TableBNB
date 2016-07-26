//
//  ChefInformationStyleSheet.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/26/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import PopupDialog

// MARK: - ChefInformationStyleSheet

enum ChefInformationStyleSheet: ViewPreparer {
    
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