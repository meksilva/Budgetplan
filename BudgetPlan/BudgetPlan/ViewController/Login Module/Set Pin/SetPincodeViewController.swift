//
//  SetPincodeViewController.swift
//  BudgetPlan


import UIKit
import SwiftMessages
import LocalAuthentication
import AudioToolbox

class SetPincodeViewController: UIViewController {

    var arr_Icon : NSMutableArray = [0,0,0,0]
    var arr_Icon2 : NSMutableArray = [0,0,0,0]
    
    @IBOutlet var button : [UIButton]!
    
    //Declaration TextField Image
    @IBOutlet weak var img_First: UIImageView!
    @IBOutlet weak var img_Second: UIImageView!
    @IBOutlet weak var img_Third: UIImageView!
    @IBOutlet weak var img_Forth: UIImageView!
    
    @IBOutlet weak var lbl_Title_Result: UILabel!
    
    
    var bool_Compaire : Bool = false
    
    var secondTime : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        //Set navigation bar title text
        navigationAppTitle(view : self, title : "create",title2 : "account")
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        if secondTime == false {
            self.navigationController? .setNavigationBarHidden(false, animated: true)
            
            bool_Compaire = false
            lbl_Title_Result.text = "Create a 4 digit PIN for secure\naccess to your account."
            arr_Icon = [0,0,0,0]
            arr_Icon2 = [0,0,0,0]
            self.arr_IconSet()
        }else{
            //Show touch id for secury password
            if objUser?.str_TouchId as! String == "1"{
                self.authenticateUser()
            }
            self.navigationController? .setNavigationBarHidden(true, animated: true)
            
            let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
            self.navigationItem.backBarButtonItem = backButton
            
            lbl_Title_Result.text = "Please enter your password"
            
            let str : String = objUser?.str_Password as! String
            
            let myText = Array(str.characters)
            
            arr_Icon = [Int(String(myText[0])),Int(String(myText[1])),Int(String(myText[2])),Int(String(myText[3]))]
            print(arr_Icon[0])
            
            bool_Compaire = true
            arr_Icon2 = [0,0,0,0]
            self.arr_IconSet()
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Other Files -
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        
                        manageTabBarandSideBar()
                    } else {
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    //MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    @IBAction func btn_Back2(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    func arr_IconSet()  {
        img_First.image = UIImage(named:"icon_Password")
        img_Second.image = UIImage(named:"icon_Password")
        img_Third.image = UIImage(named:"icon_Password")
        img_Forth.image = UIImage(named:"icon_Password")
        
        if bool_Compaire == false{
            for i in (0..<4){
                if arr_Icon[i] as! Int != 0{
                    switch(i){
                    case 0:
                        img_First.image = UIImage(named:"icon_Password_Selected")
                        break
                        
                    case 1:
                        img_Second.image = UIImage(named:"icon_Password_Selected")
                        break
                        
                    case 2:
                        img_Third.image = UIImage(named:"icon_Password_Selected")
                        break
                        
                    case 3:
                        img_Forth.image = UIImage(named:"icon_Password_Selected")
                        break
                        
                    default:
                        
                        break
                    }
                }
            }
        }else{
            for i in (0..<4){
                if arr_Icon2[i] as! Int != 0{

                    switch(i){
                    case 0:
                        img_First.image = UIImage(named:"icon_Password_Selected")
                        break
                        
                    case 1:
                        img_Second.image = UIImage(named:"icon_Password_Selected")
                        break
                        
                    case 2:
                        img_Third.image = UIImage(named:"icon_Password_Selected")
                        break
                        
                    case 3:
                        img_Forth.image = UIImage(named:"icon_Password_Selected")
                        break
                        
                    default:
                        
                        break
                    }
                }
            }
        }
    }
    
    
    //MARK: - Button Event -
    @IBAction func btn_Tab(_ sender: UIButton) {
        //Previous selected tab deselected
        
        if sender.tag != 11 {
            var int_value : Int = 0
            if bool_Compaire == false{
                for i in (0..<4){
                    if arr_Icon[i] as! Int == 0{
                        arr_Icon[i] = Int(sender.tag)
                        int_value = i
                        break
                    }
                }
                
                if int_value == 3{

                    Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(nowConfirmPassword), userInfo: nil, repeats: false)

                }
            }else{
                for i in (0..<4){
                    if arr_Icon2[i] as! Int == 0{
                        arr_Icon2[i] = Int(sender.tag)
                        int_value = i
                        break
                    }
                }
                
                
                if int_value == 3{
                    var bool_Match = true
                    
                    for i in (0..<4){
                        if arr_Icon[i] as! Int != arr_Icon2[i] as! Int{
                            bool_Match = false
                            break
                        }
                    }
                    
                    if bool_Match == false{
                        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(confirmPasswordNotmatch), userInfo: nil, repeats: false)

                    }else{
                        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(passwordSucssfully), userInfo: nil, repeats: false)

                    }
                }else{
                     if secondTime == false {
                        lbl_Title_Result.text = "Confirm your 4 digit PIN"
                     }else{
                        lbl_Title_Result.text = "Please enter your password"
                    }
                }
            }
        }else{
             if bool_Compaire == false{
                for i in (0..<4){
                    if arr_Icon[3-i] as! Int != 0{
                        arr_Icon[3-i] = 0
                        break
                    }
                }
             }else{
                for i in (0..<4){
                    if arr_Icon2[3-i] as! Int != 0{
                        arr_Icon2[3-i] = 0
                        break
                    }
                }
            }
        }
        
        self.arr_IconSet()
    }

    @objc func nowConfirmPassword() {
        bool_Compaire = true
        lbl_Title_Result.text = "Confirm your 4 digit PIN"
        self.arr_IconSet()

    }
    @objc func confirmPasswordNotmatch() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
         if secondTime == false {
            lbl_Title_Result.text = "Confirm password not match"
            arr_Icon2 = [0,0,0,0]
            self.arr_IconSet()
         }else{
            lbl_Title_Result.text = "Please enter your password"
            arr_Icon2 = [0,0,0,0]
            self.arr_IconSet()
        }
    }
    @objc func passwordSucssfully() {
        
         if secondTime == false {
            //Alert show for Header
            messageBar.MessageShow(title: "Password set successfully", alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)
            
            self.performSegue(withIdentifier: "setusername", sender: self)
            
            var str_String : String = ""
            for i in (0..<4){
                str_String = ("\(str_String)\(arr_Icon[i])")
            }
            
            objUser?.str_Password = str_String
            saveCustomObject(objUser!, key: "userobject");
         }else{
            manageTabBarandSideBar()
            
        }
            
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
