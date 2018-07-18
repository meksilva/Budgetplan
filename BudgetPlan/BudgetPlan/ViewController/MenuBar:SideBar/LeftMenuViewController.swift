//
//  LeftMenuViewController.swift
//

import UIKit
//import SlideMenuControllerSwift
import SwiftMessages
import SDWebImage

enum LeftMenu: Int {
    case home = 0
    case setting
    case logout
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftMenuCell : UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
}

class LeftMenuViewController : UIViewController, LeftMenuProtocol , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    //Declaration
    @IBOutlet weak var tableView: UITableView!
    
    //Declaration Images
    @IBOutlet weak var img_ProfileSub: UIImageView!
    @IBOutlet weak var img_Profile: UIImageView!
    
    //Manage array for ExskuderMenu controller

      var menus = ["Linked Accounts","Edit Income","Notifications","Passcode & Touch ID","Send Feedback","Rate BudgetPlan","Share with Friends","Terms & Privacy","Log Out"]
    
    //Label Declaration
    @IBOutlet var lbl_Name : UILabel!
    @IBOutlet var lbl_HashTag : UILabel!
    
    //Alloc init viewcontroller
    var TabBarViewController: UIViewController!
    var LikedAccountViewController: UIViewController!
    var IncomeViewController: UIViewController!
    
    var HomeView : HomeViewController!
    
    //Declare Sidebar controller
    var leftMenuSize = SlideMenuOptions.leftViewWidth
    var size : SlideMenuController = SlideMenuController()
    
    //View Manage
    @IBOutlet var vw_Profile : UIView!
    
    //Constant ste
    @IBOutlet var con_vw_Top : NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vw_BaseView = self
    
        //Declaration number of view added in left view contoller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //1. Home controller
        HomeView = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.TabBarViewController = UINavigationController(rootViewController: HomeView)
        
        //2. Linked controller
        let LikedAccountViewController = storyboard.instantiateViewController(withIdentifier: "LikedAccountViewController") as! LikedAccountViewController
        self.LikedAccountViewController = UINavigationController(rootViewController: LikedAccountViewController)
        
        //3. Income controller
        let IncomeViewController = storyboard.instantiateViewController(withIdentifier: "IncomeViewController") as! IncomeViewController
        self.IncomeViewController = UINavigationController(rootViewController: IncomeViewController)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        self.commanMethod()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    // MARK: - Other Files -
    //Method for change view with other screen calling
    func commanMethod(){
       
    }
    func callmethod(_int_Value : Int) {
        switch _int_Value {
        case 1:
            
            self.slideMenuController()?.changeMainViewController(self.TabBarViewController, close: true)
            self.HomeView.moveOtherView(view:1)
            break
            
        case 2:
            
            self.slideMenuController()?.changeMainViewController(self.TabBarViewController, close: true)
            self.HomeView.moveOtherView(view:2)
            break
        case 3:
            
            self.slideMenuController()?.changeMainViewController(self.TabBarViewController, close: true)
            self.HomeView.moveOtherView(view:3)
            break

        case 8:
            let alert = UIAlertController(title: GlobalConstants.appName, message: "Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
                
                //Store data nill value when user logout
                let defaults = UserDefaults.standard
                defaults.removeObject(forKey: "userobject")
                defaults.synchronize()
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let nav: UINavigationController! = (appDelegate.window?.rootViewController as! UINavigationController)
                nav.popToRootViewController(animated: true)
                
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
            
        default:
            break
        }
    }
    
    //For didselect method for present view controller
    func changeViewController(_ menu: LeftMenu) {

        }
    
    // MARK: - Button Event -
    @IBAction func btn_Close(_ sender: Any){
        closeLeft()
    }
}


// MARK: - Tableview Delegate -

extension LeftMenuViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuCell", for:indexPath as IndexPath) as! LeftMenuCell

        //Declare text in icon in tableview cell
        cell.lblTitle.text = menus[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.callmethod(_int_Value: indexPath.row)
        
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
    
}
