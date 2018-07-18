//
//  LoginViewController.swift
//  BudgetPlan


import UIKit
import SwiftMessages
import LocalAuthentication
import IQKeyboardManagerSwift

class LoginViewController: UIViewController {

    //Declaration TextFiled
    @IBOutlet weak var tf_Email: UITextField!
    @IBOutlet weak var tf_Password: UITextField!
    
    //Declaration TextField Image
    @IBOutlet weak var tbl_Main: UITableView!
    
    //View declaration
    @IBOutlet weak var vw_Notification: UIView!
    
    //Label Declaration
    @IBOutlet weak var lbl_Notificaiton: UILabel!
    
    //Button Event
    @IBOutlet weak var btn_PasswordShow: UIButton!
    @IBOutlet weak var btn_Registration: UIButton!
    
    //Comman Declaration
    var isValidEmail : Bool = false
    
    //Layout Constant
    @IBOutlet weak var con_BottomTableView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.commanMethod()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController? .setNavigationBarHidden(true, animated: true)
        
        IQKeyboardManager.sharedManager().enable = false
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().shouldShowTextFieldPlaceholder = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        IQKeyboardManager.sharedManager().shouldShowTextFieldPlaceholder = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Other Files -
    func commanMethod(){
        
        vw_Notification.isHidden = true
        btn_Registration.alpha = 0.5
        
        //Table view header heigh set
        let vw : UIView = tbl_Main.tableFooterView!
        vw.frame = CGRect(x: 0, y: 0, width: GlobalConstants.windowWidth, height: GlobalConstants.windowHeight-20)
        tbl_Main.tableFooterView = vw;
        
        //Texteding
        tf_Email.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        tf_Password.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        //Notificaitno event with keyboard show and hide
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(myKeyboardWillHideHandler),
            name: .UIKeyboardWillHide,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(myKeyboardWillShow),
            name: .UIKeyboardWillShow,
            object: nil)
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
    func validationView() -> Bool{
        if((tf_Email.text?.isEmpty)! ){
            
            lbl_Notificaiton.text = "Please enter email address"
            vw_Notification.backgroundColor = GlobalConstants.commanWrong
            
            return false
        }else if(isValidEmail ==  validateEmail(enteredEmail: tf_Email.text!)){
            
            lbl_Notificaiton.text = "Please enter valid email address"
            vw_Notification.backgroundColor = GlobalConstants.commanWrong
            
            return false
        }else if((tf_Password.text?.isEmpty)!){
            
            lbl_Notificaiton.text = "Please enter password"
            vw_Notification.backgroundColor = GlobalConstants.commanWrong
            
            return false
        }
        else if(self.validationPassword(tf_Get : tf_Password,condition : true) == false){
            
            lbl_Notificaiton.text = "Let's make sure your password is strong.\n8 or more characters with at least 1 letter & 1 number."
            vw_Notification.backgroundColor = GlobalConstants.commanWrong
            
            return false
        }
        
        lbl_Notificaiton.text = "Awesome!\nYour password looks strong and secure."
        vw_Notification.backgroundColor = GlobalConstants.commanRight
        return true
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
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func btn_Registration(_ sender:Any){
       
        if btn_Registration.alpha == 1.0{
            //Image hide show manage
           vw_Notification.isHidden = false

            var boolEmail : Bool = true
            var boolPassword : Bool = true

            if((tf_Email.text?.isEmpty)! && GlobalConstants.developerTest == false){
                //Alert show for Header
                
                lbl_Notificaiton.text = "Please enter email address"
                vw_Notification.backgroundColor = GlobalConstants.commanWrong
                btn_Registration.alpha = 0.5

                boolEmail = false

            }else if(isValidEmail ==  validateEmail(enteredEmail: tf_Email.text!) && GlobalConstants.developerTest == false){
                if isValidEmail == true {

                }else{
                    //Alert show for Header

                    lbl_Notificaiton.text = "Please enter valid email address"
                    vw_Notification.backgroundColor = GlobalConstants.commanWrong
                    btn_Registration.alpha = 0.5
                    
                    boolEmail = false

                }
            }

            if boolEmail == true{

                if((tf_Password.text?.isEmpty)! && GlobalConstants.developerTest == false){

                    boolPassword = false


                    lbl_Notificaiton.text = "Please enter password"
                    vw_Notification.backgroundColor = GlobalConstants.commanWrong
                    btn_Registration.alpha = 0.5
                    
                }else if self.validationPassword(tf_Get : tf_Password,condition : true) == false && GlobalConstants.developerTest == false{
                    //Alert show for Header

                    boolPassword = false
                    
                    lbl_Notificaiton.text = "Let's make sure your password is strong.\n8 or more characters with at least 1 letter & 1 number."
                    vw_Notification.backgroundColor = GlobalConstants.commanWrong
                    btn_Registration.alpha = 0.5
                }

            }else{
            }

            if boolEmail == true && boolPassword == true{
                self.view.endEditing(true)

                messageBar.MessageShow(title: "Login successfully", alertType: MessageView.Layout.cardView, alertTheme: .success, TopBottom: true)

                manageTabBarandSideBar()
                
                //Store data in object
                let obj = UserDataObject(str_Email: tf_Email.text!,
                                         str_TouchId: "1",
                                         str_Password: "1234",
                                         str_UserName: "Login User")
                
                saveCustomObject(obj, key: "userobject");
                
                //Save Object In global variable
                objUser = obj
                
            }
        }
    }
    @IBAction func btn_PasswordShow(_ sender:Any){
        if btn_PasswordShow.isSelected == false{
            btn_PasswordShow.isSelected = true
            tf_Password.isSecureTextEntry = false
            btn_PasswordShow .setTitle("HIDE", for: UIControlState.normal)
        }else{
            btn_PasswordShow.isSelected = false
            tf_Password.isSecureTextEntry = true
            btn_PasswordShow .setTitle("SHOW", for: UIControlState.normal)
        }
    }
    @IBAction func btn_ForgotePassword(_ sender:Any){
        
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
extension LoginViewController : UITextFieldDelegate{
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        vw_Notification.isHidden = false
        
        if((tf_Email.text?.isEmpty)! && GlobalConstants.developerTest == false){
            
            lbl_Notificaiton.text = "Please enter email address"
            vw_Notification.backgroundColor = GlobalConstants.commanWrong
            btn_Registration.alpha = 0.5
            
            
        }else if(isValidEmail ==  validateEmail(enteredEmail: tf_Email.text!) && GlobalConstants.developerTest == false){
            if isValidEmail == true {
                if self.validationPassword(tf_Get : tf_Password,condition : true) == true{
                    btn_Registration.alpha = 1.0
                }
            }else{
                
                lbl_Notificaiton.text = "Please enter valid email address"
                vw_Notification.backgroundColor = GlobalConstants.commanWrong
                btn_Registration.alpha = 0.5
            }
        }else if self.validationPassword(tf_Get : tf_Password,condition : true) == false{
            
            lbl_Notificaiton.text = "Let's make sure your password is strong.\n8 or more characters with at least 1 letter & 1 number."
            vw_Notification.backgroundColor = GlobalConstants.commanWrong
            btn_Registration.alpha = 0.5
        }else{
            
            lbl_Notificaiton.text = "Awesome!\nYour password looks strong and secure."
            vw_Notification.backgroundColor = GlobalConstants.commanRight
            btn_Registration.alpha = 1.0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        self.view.endEditing(true)
        return true;
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if self.validationView() == false{
            btn_Registration.alpha = 0.5
        }else{
            btn_Registration.alpha = 1.0
        }
    }
}
