//
//  WelcomeViewController.swift
//  BudgetPlan

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.alredyLoginOrNot()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController? .setNavigationBarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Other methods -
    func alredyLoginOrNot(){
        if ((loadCustomObject(withKey: "userobject")) != nil){
            var objUserTemp : UserDataObject = loadCustomObject(withKey: "userobject")!
            
            //Condition get data from userdefault
            if objUserTemp.str_UserName.characters.count != 0 {
                
                objUser = objUserTemp
                self.performSegue(withIdentifier: "passwordsecondtime", sender: self)

            }
        }
    }
    
    
    //MARK: - Button Event -
    @IBAction func btn_GetStart(_ sender:Any){
        
    }
    @IBAction func btn_Login(_ sender:Any){
        
    }
    @IBAction func btn_ForgotePassword(_ sender:Any){
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "passwordsecondtime"{
            let view : SetPincodeViewController = segue.destination as! SetPincodeViewController
            view.secondTime = true
        }else if segue.identifier == "welcome2forgot"{
            let view : ForgotViewController = segue.destination as! ForgotViewController
            view.boolGoingBack = false
        }
    }
    

}
