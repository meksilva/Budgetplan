//
//  SelfiSelectionViewController.swift
//  BudgetPlan

import UIKit

class SelfiSelectionViewController: UIViewController {

    //Declaration Label
    @IBOutlet weak var lbl_UserName: UILabel!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
    }
    override func viewWillAppear(_ animated: Bool) {
        //Set navigation bar title text
        navigationAppTitle(view : self, title : "create",title2 : "account")
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Other Files -
    func commanMethod(){
        lbl_UserName.text = objUser?.str_UserName
    }
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func btn_Back2(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_Sure(_ sender:Any){
       
        self.performSegue(withIdentifier: "selectedphoto", sender: self)
    }
    @IBAction func btn_MayBeLater(_ sender:Any){
        self.performSegue(withIdentifier: "addbillfirsttime", sender: self)
    }

    /// In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "selectedphoto"{
            
            let view : SelfiePreviewViewController = segue.destination as! SelfiePreviewViewController
            view.str_Select = "1"
        }
        
    }

}


