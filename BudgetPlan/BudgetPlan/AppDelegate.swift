//
//  AppDelegate.swift
//  BudgetPlan

import UIKit
import IQKeyboardManagerSwift

//Global Declaration
var messageBar = MessageBarController()
var vw_BaseView: LeftMenuViewController?

let obj_AddBill = AddBillViewObject ()
let obj_AddIncome = AddIncomeViewObject ()
var vw_HomeView: HomeViewController?

var objUser : UserDataObject?
var objAddNewBill : MyBudgetViewObject?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Text editing manager
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        IQKeyboardManager.sharedManager().shouldShowTextFieldPlaceholder = true
        
        //Navigation set
        self.navigationSet()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Navigation Manager -
    func navigationSet() {
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(UIImage(named: "icon_Back"), for: .normal, barMetrics: .default)
        UINavigationBar.appearance().setBackgroundImage(image(with: UIColor(red: 20/256, green: 51/256, blue: 77/256, alpha: 1.0)), for: .default)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont(name:  GlobalConstants.font_OpenSans, size: 17.0)!]
        UINavigationBar.appearance().shadowImage = UIImage(named: "img_Shadow")
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
    }

    // MARK: - Make Image with Color -
    func image(with color: UIColor) -> UIImage {
        let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(1.0), height: CGFloat(1.0))
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
}

func setNavigationMethod(view : UIViewController){
    let logo = UIImage(named: "img_PhotoSelection")
    let imageView = UIImageView(image:logo)
    view.navigationItem.titleView = imageView
    
}

//MARK: -- Email Validation --
func validateEmail(enteredEmail:String) -> Bool {
    
    let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    return emailPredicate.evaluate(with: enteredEmail)
}

func validatePhoneNumber(value: String) -> Bool {
    let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
    let inputString = value.components(separatedBy: charcterSet)
    let filtered = inputString.joined(separator: "")
    return  value == filtered
}

func dateTimeFormate(date : String,type : String) -> String{
    
    //End data
    var dateString = date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    //Current Data
    var dateNew = dateFormatter.date(from: dateString)
    
    if type == "1"{
        //Required formate convert
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: dateNew!)
    }else if type == "2"{
        //Required formate convert
        dateFormatter.dateFormat = "HH:mm a"
        return dateFormatter.string(from: dateNew!)
    }
    
    
    return ""
}


//MARK: -- Set up Tabbar and sidebar controller --
func manageTabBarandSideBar(){
    //Store data in object
    
    //Declare alloc init for storyboard/Mange Tab bar
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let mainViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
    
    let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
    
    //Declare Slidemenucontroller with connect sidebar and menubar
    let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
    slideMenuController.automaticallyAdjustsScrollViewInsets = true
    slideMenuController.delegate = mainViewController
    
    let calculationValue = GlobalConstants.windowWidth
    slideMenuController.changeLeftViewWidth(CGFloat(calculationValue))
    
    //Manage Slidemenu
    SlideMenuOptions.hideStatusBar = false
    SlideMenuOptions.contentViewOpacity = 0.0
    SlideMenuOptions.contentViewScale = 1.0
    
    //Call navigation with push view controller
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    _ =  mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    
    let appDelegate2 = UIApplication.shared.delegate as! AppDelegate
    let nav2: UINavigationController! = (appDelegate2.window?.rootViewController as! UINavigationController)
    nav2?.pushViewController(slideMenuController, animated: false)
}



//MARK: --User Object--
func saveCustomObject(_ object: UserDataObject, key: String) {
    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: object)
    let defaults = UserDefaults.standard
    defaults.set(encodedObject, forKey: key)
    defaults.synchronize()
}

func loadCustomObject(withKey key: String) -> UserDataObject? {
    let defaults = UserDefaults.standard
    let encodedObject: Data? = defaults.object(forKey: key) as! Data?
    if encodedObject != nil {
        let object: UserDataObject? = NSKeyedUnarchiver.unarchiveObject(with: encodedObject!) as! UserDataObject?
        return object!
    }
    return nil
}

//MARK: --Navigation Title Set--
func navigationAppTitle(view : UIViewController,title : String,title2 : String){
    let str_Combination : String = title + title2
    
    //Create Attribute object
    let attribute1 = [NSAttributedStringKey.foregroundColor: UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1), NSAttributedStringKey.font: UIFont(name: GlobalConstants.font_Questrial, size: 22)!]
    let attribute2 = [NSAttributedStringKey.foregroundColor: UIColor(red: 125 / 255.0, green: 173 / 255.0, blue: 35 / 255.0, alpha: 1), NSAttributedStringKey.font: UIFont(name: GlobalConstants.font_Questrial, size: 22)!]
    
    //Create range of String
    let myRange = NSRange(location: 0, length: title.characters.count)
    let myRange2 = NSRange(location: title.characters.count, length: title2.characters.count)
    
    //String object
    let attributedText = NSMutableAttributedString(string: str_Combination)
    
    //Set range in attribute string
    attributedText.setAttributes(attribute1, range: myRange)
    attributedText.setAttributes(attribute2, range: myRange2)
    
    //Label create
    let label = UILabel()
    
    //Pass attribute string in uilabel
    label.attributedText = attributedText
    
    //Set label in navigationtitle
    view.navigationItem.titleView = label
    view.navigationItem.titleView?.sizeToFit()
}


func addCommaInPrize(value : Double) -> String{
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = NumberFormatter.Style.decimal
    let formattedNumber = numberFormatter.string(from: NSNumber(value:value))
    
    return formattedNumber!
    
}
//MARK: - Calculate widht or height of string -
extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
}

func manageIphoneX() -> Double{
    if GlobalConstants.windowHeight == 812{
        return GlobalConstants.windowHeight-78
    }else{
        return GlobalConstants.windowHeight-20
    }
}


