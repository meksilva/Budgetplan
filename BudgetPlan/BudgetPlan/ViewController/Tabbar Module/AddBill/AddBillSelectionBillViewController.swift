//
//  AddBillSelectionBillViewController.swift
//  BudgetPlan

import UIKit

class AddBillSelectionBillViewController: UIViewController {

    //Other Declartion
    var boolBack : Bool = false
    
    //Declaration label
    @IBOutlet weak var lbl_Header: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Other Files -
    func commanMethod(){
        
        //Set navigation bar title text
        navigationAppTitle(view : self, title : "add",title2 : "bill")
        
        let colorAttribute = [NSAttributedStringKey.foregroundColor: UIColor.init(red: 19/256, green: 19/256, blue: 19/256, alpha: 1), NSAttributedStringKey.font: UIFont(name:  GlobalConstants.font_OpenSans, size: 16)!]
        let whiteAttribute = [NSAttributedStringKey.foregroundColor: UIColor.init(red: 130/256, green: 183/256, blue: 58/256, alpha: 1), NSAttributedStringKey.font:UIFont(name:  GlobalConstants.font_OpenSans, size: 16)!]
        
        let part1 = NSMutableAttributedString(string: "What ", attributes: colorAttribute)
        let part2 = NSMutableAttributedString(string: "type ", attributes: whiteAttribute)
        let part3 = NSMutableAttributedString(string: "of bill is this?", attributes: colorAttribute)
        
        let combination = NSMutableAttributedString()
        
        combination.append(part1)
        combination.append(part2)
        combination.append(part3)
        
        lbl_Header?.attributedText = combination
     
        if boolBack == true {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        if boolBack == false {
            self.navigationController?.popToRootViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func btn_Back2(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Subcription(_ sender:Any){
        self.performSegue(withIdentifier: "addbill", sender: "Subscription/Recurring")
    }
    @IBAction func btn_Debt(_ sender:Any){
        self.performSegue(withIdentifier: "addbill", sender: "Fixed Debt/Credit Card")
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "addbill" {
            let  view  = segue.destination as! AddBillViewController
            view.boolBack = boolBack
            view.str_BillType = sender as! String
        }
        
    }

}
