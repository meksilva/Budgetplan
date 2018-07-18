//
//  UserNameViewController.swift
//  BudgetPlan


import UIKit
import SwiftMessages
import IQKeyboardManagerSwift

class UserNameViewController: UIViewController {

    //Declaration TextFiled
    @IBOutlet weak var tf_FirstName: UITextField!
    @IBOutlet weak var tf_LastName: UITextField!
    
    //Button Declaration
    @IBOutlet weak var btn_LetsGo: UIButton!
    
    //Layout Constant
    @IBOutlet weak var con_BottomTableView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
        
        btn_LetsGo.alpha = 0.5
        
        //Texteding
        tf_FirstName.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        tf_LastName.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //Set navigation bar title text
        navigationAppTitle(view : self, title : "create",title2 : "account")
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        
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
    
    //MARK: Other Method -
    func commanMethod(){
        
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
    func validationView() -> Bool{
        if((tf_FirstName.text?.isEmpty)! ){
            
          btn_LetsGo.alpha = 0.5
            
            return false
        }

        btn_LetsGo.alpha = 1.0
        
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
            self.con_BottomTableView.constant = -CGFloat(GlobalConstants.windowHeight * 0.2)
            
            self.view .layoutIfNeeded()
        }, completion: nil)
        
        
    }
    
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func btn_Back2(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_letsFriend(_ sender:Any){
        
        if btn_LetsGo.alpha == 1.0{
            if(tf_FirstName.text == "" && GlobalConstants.developerTest == false){
                btn_LetsGo.alpha = 0.5
            }
            else{
                //Save UserNmae Into Userobject
                objUser?.str_UserName = "\(tf_FirstName.text!)"
                saveCustomObject(objUser!, key: "userobject");
                
                self.performSegue(withIdentifier: "selfie", sender: self)
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
extension UserNameViewController : UITextFieldDelegate{
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if tf_FirstName.text == ""{
                btn_LetsGo.alpha = 0.5
             }else{
                btn_LetsGo.alpha = 1.0
            }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        self.view.endEditing(true)
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)

        if tf_FirstName == textField{
            if newString != ""{
                btn_LetsGo.alpha = 1.0
            }else{
                btn_LetsGo.alpha = 0.5
            }
        }
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if self.validationView() == false{
            btn_LetsGo.alpha = 0.5
        }else{
            btn_LetsGo.alpha = 1.0
        }
    }
}
