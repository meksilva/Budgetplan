//
//  Constant.swift

import Foundation
import UIKit

struct GlobalConstants {
    // Constant define here.
    static let developerTest : Bool = false
    
    //Implementation View height
    static let screenHeightDeveloper : Double = 667
    static let screenWidthDeveloper : Double = 375
    
    //Base URL
    static let BaseURL = ""
    
    //Name And Appdelegate Object
    static let appName: String = "BudgetPlan"
    static let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
    
    //System width height
    static let windowWidth: Double = Double(UIScreen.main.bounds.size.width)
    static let windowHeight: Double = Double(UIScreen.main.bounds.size.height)
    
    //Font
    static let kFontLight = "Avenir-Light"
    static let kFontRegular = "Avenir-Book"
    static let kFontSemiBold = "Avenir-Medium"
    static let kFontBold = "Avenir-Heavy"
    
    //Google Api forKey
    static let apiKeyGoogle = "AIzaSyCuuATFaZqxiN-7tvSkEvEN41G1GP_M3uE"
    
    //Loading data pagination
    static let int_LoadMax = 6
    static let int_LoadMaxCollection = 12
    
    //Google AnalityKey
    static let apiKeyGoogleAnality = "UA-105722820-1"
    
    //Device Token
    static let DeviceToken = UserDefaults.standard.object(forKey: "DeviceToken")
    
    //Place holder
    static let placeHolder_User = "icon_PlaceHolderUser"
    static let placeHolder_Comman = "icon_PlaceHolderSquare"
    
    static let font_Questrial = "Questrial-Regular"
    static let font_OpenSans = "OpenSans"
    static let font_OpenSansBold = "OpenSans-Bold"
    static let font_OpenSansLight = "OpenSans-Light"
    static let font_OpenSansSemiBold = "OpenSans-Semibold"
    static let font_OpenSansItali = "OpenSans-Italic"
    static let font_SFUITextRegular = "SanFranciscoText-Regular"
    static let font_SFUITextLight = "SanFranciscoText-Light"
    static let font_SFUITextLightItali = "SanFranciscoText-Italic"
    static let font_SFUITextSemiBold = "SanFranciscoText-Semibold"
    static let font_SFUIDisplayRegular = "SanFranciscoDisplay-Regular"
    static let font_SFUIDisplayUltraLight = "SanFranciscoDisplay-Ultralight"
    static let font_SFUIDisplayLight = "SanFranciscoDisplay-Light"
    
    //App Color
    static let appColor = UIColor(red: 31/255, green: 56/255, blue: 83/255, alpha: 1.0)
    
    //SIgn In Up Validaiton Color
    //App Color
    static let commanRight = UIColor(red: 31/255, green: 56/255, blue: 83/255, alpha: 1.0)
    static let commanWrong = UIColor(red: 74/255, green: 163/255, blue: 222/255, alpha: 1.0)
}



public enum GlobalAppValidation {
    case open
    case close
}
