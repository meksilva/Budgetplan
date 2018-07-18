//
//  ForgotViewController.swift
//  BudgetPlan


import UIKit
import SwiftMessages
import LocalAuthentication
import IQKeyboardManagerSwift

class ForgotViewController: UIViewController {
    
    //Declaration TextFiled
    @IBOutlet weak var tf_Email: UITextField!
    
    //Declaration TextField Image
    @IBOutlet weak var tbl_Main: UITableView!
    
    //View declaration
    @IBOutlet weak var vw_Notification: UIView!
    @IBOutlet weak var vw_EmailBox: UIView!
    
    //Label Declaration
    @IBOutlet weak var lbl_Notificaiton: UILabel!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_EmailSuccess: UILabel!
    
    //Constant Set
    @IBOutlet weak var con_EmailSend: NSLayoutConstraint!
    
    //Button Event
    @IBOutlet weak var btn_ResetPassword: UIButton!
    
    //Comman Declaration
    var isValidEmail : Bool = false
    
    //Layout Constant
    @IBOutlet weak var con_BottomTableView: NSLayoutConstraint!
    
    //IF going back than back to login screen and fallse than masage this scren open from welcome screen
    var boolGoingBack : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commanMethod()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController? .setNavigationBarHidden(true, animated: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Other Files -
    func commanMethod(){
        
        vw_Notification.isHidden = true
        lbl_EmailSuccess.isHidden = true
        btn_ResetPassword.alpha = 0.5
        
        //Table view header heigh set
        let vw : UIView = tbl_Main.tableFooterView!
        vw.frame = CGRect(x: 0, y: 0, width: GlobalConstants.windowWidth, height: manageIphoneX())
        tbl_Main.tableFooterView = vw;

    }
    func validationForLogin(int_Value : Int){
        //Image hide show manage
    }
    func validationPassword(tf_Get : UITextField,condition : Bool) -> Bool{
        
        //Validation for 1 Capital 1 Number value and 8 Length
        var validation : Int = 0
        
        //1 8 character Validatiaon
        if (tf_Get.text!.characters.count >= 8) {
            validation = validation + 1;
        }
        
        //2 capital letter or not
        var output = ""
        let string : String = tf_Get.text!
        for chr in string.characters {
            let str = String(chr)
            if str.lowercased() != str {
                output += str
            }
        }
        if output != "" {
            validation = validation + 1
        }
        
        //3 Number
        let str = tf_Get.text!
        let intString = str.components(
            separatedBy: NSCharacterSet
                .decimalDigits
                .inverted)
            .joined(separator: "")
        if intString != "" {
            validation = validation + 1
        }
        
        if validation > 2 {
            return true
        }
        
        return false
    }
    //Custome class keyboard handler method
    @objc func myKeyboardWillHideHandler(_ notification: NSNotification) {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowAnimatedContent], animations: {
            self.con_BottomTableView.constant = 0
            
            self.view .layoutIfNeeded()
        }, completion: nil)
    }
    @objc func myKeyboardWillShow(_ notification: NSNotification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        self.view .layoutIfNeeded()
        
        //Scrollview animation when keyboard open
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowAnimatedContent], animations: {
            //Set constant with screen size
            self.con_BottomTableView.constant = keyboardHeight
            self.tbl_Main.contentOffset = CGPoint(x: 0, y: CGFloat(keyboardHeight - CGFloat(GlobalConstants.windowHeight * 0.2)))
            
            self.view .layoutIfNeeded()
        }, completion: nil)
        
        
    }
    
    
    
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_ResetPassword(_ sender:Any){
        
        if btn_ResetPassword.alpha == 1.0{
            
            if btn_ResetPassword.titleLabel?.text != "Login"{
                vw_Notification.isHidden = false
                
                var boolEmail : Bool = true
                var boolPassword : Bool = true
                
                if((tf_Email.text?.isEmpty)! && GlobalConstants.developerTest == false){
                    
                    lbl_Notificaiton.text = "Please enter email address"
                    vw_Notification.backgroundColor = GlobalConstants.commanWrong
                    btn_ResetPassword.alpha = 0.5
                    
                    boolEmail = false
                }else if(isValidEmail ==  validateEmail(enteredEmail: tf_Email.text!) && GlobalConstants.developerTest == false){
                    if isValidEmail == true {
                        
                    }else{
                        
                        lbl_Notificaiton.text = "Please enter valid email address"
                        vw_Notification.backgroundColor = GlobalConstants.commanWrong
                        btn_ResetPassword.alpha = 0.5
                        
                        boolEmail = false
                    }
                }else{
                    self.view.endEditing(true)
                    
                    vw_Notification.isHidden = true
                    vw_EmailBox.isHidden = true
                    lbl_EmailSuccess.isHidden = false
                    
                    //Manage string with email address
                    let fullNameArr = tf_Email.text?.characters.split{$0 == "@"}.map(String.init)
                    let firstCharacter = fullNameArr![0]
                    var convetedString = firstCharacter.index(firstCharacter.startIndex, offsetBy: 0)
                    
                    con_EmailSend.constant = 16
                    lbl_EmailSuccess.text = "An email has been sent to your email address,\n\(firstCharacter[convetedString])****@\(fullNameArr![1]).\nFollow the directions in the email to reset your password."
                    
                    
                    
                    lbl_Title.text = "Password Reset Email Sent"
                    btn_ResetPassword .setTitle("Login", for: UIControlState.normal)
 
                }
            }else{
                if boolGoingBack == true{
                    self.navigationController?.popViewController(animated: true)
                }else{
                    self.performSegue(withIdentifier: "login", sender: self)
                }
            }
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


//MARK: - UITextField Delegates -
extension ForgotViewController : UITextFieldDelegate{
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        vw_Notification.isHidden = false
        
        if((tf_Email.text?.isEmpty)! && GlobalConstants.developerTest == false){
            
            lbl_Notificaiton.text = "Please enter email address"
            vw_Notification.backgroundColor = GlobalConstants.commanWrong
            btn_ResetPassword.alpha = 0.5
            
            
        }else if(isValidEmail ==  validateEmail(enteredEmail: tf_Email.text!) && GlobalConstants.developerTest == false){
            if isValidEmail == true {

            }else{
                
                lbl_Notificaiton.text = "Please enter valid email address"
                vw_Notification.backgroundColor = GlobalConstants.commanWrong
                btn_ResetPassword.alpha = 0.5
            }
        }else{
            btn_ResetPassword.alpha = 1.0
            vw_Notification.isHidden = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        self.view.endEditing(true)
        return true;
    }
}

