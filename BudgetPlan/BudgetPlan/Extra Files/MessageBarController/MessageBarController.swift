//
//  MessageBarController.swift


import UIKit
import SwiftMessages

class MessageBarController: NSObject {
    
    
    func MessageShow(title : NSString , alertType : MessageView.Layout , alertTheme : Theme , TopBottom : Bool) -> Void {
        //Hide All popup when present any one popup
       // SwiftMessages.hideAll()
        
        //Top Bottom
        //1 = Top , 2 = Bottom
        
        let alert = MessageView.viewFromNib(layout: alertType)
        alert.titleLabel?.font =  UIFont(name: GlobalConstants.kFontSemiBold, size: 18.0)!
        alert.bodyLabel?.font =  UIFont(name: GlobalConstants.kFontSemiBold, size: 18.0)!
        
        //Alert Type
        alert.configureTheme(alertTheme)
        alert.configureDropShadow()
        alert.button?.isHidden = true
        
        //Set title value
        alert.configureContent(title: "", body: title as String)

        var successConfig = SwiftMessages.defaultConfig
        
        //Type for present popup is bottom or top
        (TopBottom == true) ? (successConfig.presentationStyle = .top):(successConfig.presentationStyle = .bottom)
        
        //Configaration with Start with status bar
        successConfig.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        
        
        SwiftMessages.show(config: successConfig, view: alert)
    }

}
