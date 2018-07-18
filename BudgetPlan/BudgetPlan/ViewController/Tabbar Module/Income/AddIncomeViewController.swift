//
//  AddIncomeViewController.swift
//  BudgetPlan

import UIKit
import ActionSheetPicker_3_0

class AddIncomeViewController: UIViewController,DismissBillViewDelegate {
    
    //Local Declaration
    var boolFirstTime : Bool = false
    var boolEditingMode : Bool = false
    var tf_NameOfIncome: UITextField!
    var tf_Amount: UITextField!
    var boolBack : Bool = false
    
    
    //Constact declaration
    @IBOutlet weak var con_BottomErrorMessage : NSLayoutConstraint?
    
    //Button Declartion
    @IBOutlet weak var btn_AddIncome : UIButton?
    
    //Declaration tableview
    @IBOutlet weak var tbl_Main: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.validationAddIncomeButton()
        
        //Set error message box
        con_BottomErrorMessage?.constant = -100
        tbl_Main.reloadData()
        
        if boolBack == true {
             self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Popup Delegate -
    func BillEvent(info: NSInteger) {
        if info == 2 {
            
            //Set navigation bar title text
            if boolBack == false {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let view = storyboard.instantiateViewController(withIdentifier: "AddBillSelectionBillViewController") as! AddBillSelectionBillViewController
                view.boolBack = boolBack
                self.navigationController?.pushViewController(view, animated: true)
            }else{
                 self.navigationController?.popViewController(animated: true)
            }
            
        } else if info == 1 {
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(btn_Back(_:)), userInfo: nil, repeats: false)
        }
    }
    
    //MARK: - Other Files -
    func commanMethod(){
        
        //Set default value
        obj_AddIncome.str_Cateogry = "income"
        obj_AddIncome.Str_Name = ""
        obj_AddIncome.str_DueData = ""
        obj_AddIncome.str_Repeats = ""
        obj_AddIncome.str_Amount = ""
        obj_AddIncome.str_PayWhen = "1 week before here"

        if boolFirstTime == true{
            self.navigationItem.setHidesBackButton(true, animated:true)
        }
        
        //Set navigation bar title text
        if boolBack == false {
             navigationAppTitle(view : self, title : "add",title2 : "income")
            btn_AddIncome?.setTitle("Add Income", for: .normal)
        }else{
            navigationAppTitle(view : self, title : "edit",title2 : "income")
            btn_AddIncome?.setTitle("Edit Income", for: .normal)
        }
    }
    func validationAddIncomeButton(){
        btn_AddIncome?.alpha = 0.5
        
        if obj_AddIncome.str_Cateogry != "" && obj_AddIncome.str_DueData != "" && obj_AddIncome.str_Repeats != "" && (tf_Amount.text != "") {
            btn_AddIncome?.alpha = 1.0
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
    
    @IBAction func paymentdone(_ sender:Any){
        
        if btn_AddIncome?.alpha == 1.0{
            if obj_AddIncome.str_Cateogry != "" && obj_AddIncome.str_DueData != "" && obj_AddIncome.str_Repeats != "" && (tf_Amount.text != "") {
                
                //Remove $symbol in string and pass to other view
                var str_Amount = tf_Amount.text! as String
                str_Amount.remove(at: str_Amount.startIndex)
                
                let view = self.storyboard?.instantiateViewController(withIdentifier: "AddIncomeCompletedViewController") as! AddIncomeCompletedViewController
                view.delegate = self
                view.boolBack = boolBack
                view.str_BusinessName = (tf_NameOfIncome.text! == "") ? "Income #1" : tf_NameOfIncome.text!
                view.str_Prize = str_Amount
                view.str_IncomeType = obj_AddIncome.str_Cateogry
                view.str_IncomeTime = obj_AddIncome.str_Repeats
                
                view.modalPresentationStyle = .custom
                view.modalTransitionStyle = .crossDissolve
                self.present(view,animated:true,completion:nil);
            }else{
                con_BottomErrorMessage?.constant = 0
                tbl_Main.reloadData()
            }
        }else{
            con_BottomErrorMessage?.constant = 0
            tbl_Main.reloadData()
        }
    }
    @IBAction func btn_NameOfINcome(_ sender:Any){
        tf_NameOfIncome.becomeFirstResponder()
    }
    @IBAction func btn_Amount(_ sender:Any){
        tf_Amount.becomeFirstResponder()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "paymentdone" {
            let  popUpView  = segue.destination as! AddBillCompletePaymentViewController
            popUpView.delegate = self
        }
        
    }
    
}

//MARK: - AddBill Object -

class AddIncomeViewObject: NSObject {
    var str_Cateogry : String = ""
    var Str_Name : String = ""
    var str_DueData : String = ""
    var str_Repeats : String = ""
    var str_Amount : String = ""
    
    var str_PayWhen : String = ""
}


//MARK: - Tableview View Cell -
class AddIncomeCell : UITableViewCell{
    
    //Main Listing product
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Desciption: UILabel!
    @IBOutlet weak var lbl_TitleText: UILabel!
    @IBOutlet weak var lbl_Required: UILabel!
    
    @IBOutlet weak var tf_Main: UITextField!
    
    @IBOutlet weak var img_IconRight: UIImageView!
    @IBOutlet weak var img_Validation: UIImageView!
    
    //No data cell
    @IBOutlet weak var switch_Remindar : UISwitch!
    
    //Button
    @IBOutlet weak var btn_EditingOn : UIButton!
}

// MARK: - Tableview Files -
extension AddIncomeViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0{
                return 0 // HIde Category selection Field
            }
        }
        return 46
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        }else  if section == 1 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "section")as! AddIncomeCell
            
            cell.lbl_Title.text = "INCOME INFO"
            
            cell.layer.borderColor = UIColor.init(red: 230/256, green: 231/256, blue: 234/256, alpha: 1).cgColor
            cell.layer.borderWidth = 1.0
            cell.layer.masksToBounds = true
            
            return cell;
        }else if section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "section")as! AddIncomeCell
            
            cell.layer.borderColor = UIColor.init(red: 230/256, green: 231/256, blue: 234/256, alpha: 1).cgColor
            cell.layer.borderWidth = 1.0
            cell.layer.masksToBounds = true
            
            cell.lbl_Title.text = "PAYMENT SETTINGS"
            return cell;
        }else {
            return nil;
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell_Identifier = "cell"
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                cell_Identifier = "cellincome"
            }
            else if indexPath.row == 4 {
                cell_Identifier = "cellamount"
            }
            else if indexPath.row == 5 {
                cell_Identifier = "cellswitch"
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_Identifier, for:indexPath as IndexPath) as! AddIncomeCell
        
        
        cell.img_IconRight.isHidden = false
        cell.img_Validation.isHidden = true
        cell.lbl_Required.isHidden = true
        
        if indexPath.section == 0 {
            
            switch indexPath.row{
            case 0:
                cell.lbl_TitleText.text = "Category"
                cell.lbl_Desciption.text = obj_AddIncome.str_Cateogry
                
                if (obj_AddIncome.str_Cateogry == ""){

                    cell.lbl_Required.isHidden = false
                }
                if (con_BottomErrorMessage?.constant == 0 && obj_AddIncome.str_Cateogry == ""){
                    cell.img_Validation.isHidden = false
                }
                
                break
            case 1:
                cell.lbl_TitleText.text = "Name of Income"
                tf_NameOfIncome = cell.tf_Main
                cell.tf_Main.delegate = self

                cell.img_IconRight.isHidden = true
                
                cell.btn_EditingOn.addTarget(self, action: #selector(btn_NameOfINcome(_:)), for: .touchUpInside)

                tf_NameOfIncome.delegate = self
                
                break
            case 2:
                cell.lbl_TitleText.text = "Next Pay Date"
                cell.lbl_Desciption.text = obj_AddIncome.str_DueData
                cell.img_IconRight.isHidden = true
                
                 if (obj_AddIncome.str_DueData == ""){
                    cell.lbl_Required.isHidden = false
                 }
                if (con_BottomErrorMessage?.constant == 0 && obj_AddIncome.str_DueData == ""){
                    cell.img_Validation.isHidden = false
                }
                
                break
            case 3:
                cell.lbl_TitleText.text = "Pay Frequency"
                cell.lbl_Desciption.text = obj_AddIncome.str_Repeats
                
                if (obj_AddIncome.str_Repeats == ""){
                    cell.lbl_Required.isHidden = false
                }
                if (con_BottomErrorMessage?.constant == 0 && obj_AddIncome.str_Repeats == ""){
                   cell.img_Validation.isHidden = false
                }

                
                break
            case 4:
                
                cell.lbl_TitleText.text = "Amount"
                cell.tf_Main.delegate = self
                tf_Amount = cell.tf_Main
                
                if ((tf_Amount.text == "") && boolEditingMode == false){
                    cell.lbl_Required.isHidden = false
                }
                if (con_BottomErrorMessage?.constant == 0 && (tf_Amount.text == "")){
                    cell.img_Validation.isHidden = false
                }
                
                cell.btn_EditingOn.addTarget(self, action: #selector(btn_Amount(_:)), for: .touchUpInside)
                
                cell.img_IconRight.isHidden = true
                
                tf_Amount.delegate = self
                
                break
            case 5:
                cell.lbl_Title.text = "Reminders"
                cell.img_IconRight.isHidden = true
                cell.switch_Remindar.layer.cornerRadius = 15
                
                break
                
            default: break
                
            }
            
            
        }else if indexPath.section == 1 {
            
            switch indexPath.row{
            case 0:
                cell.lbl_Desciption.text = obj_AddIncome.str_PayWhen
                break
                
            default: break
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row{
            case 0:
                self.performSegue(withIdentifier: "incomecategory", sender: self)
                break
            case 1:
                break
                
            case 2:
                //Set error message box
                con_BottomErrorMessage?.constant = -100
                tbl_Main.reloadData()
                
                let datePicker = ActionSheetDatePicker(title: "Date:", datePickerMode: UIDatePickerMode.date, selectedDate: NSDate() as Date!, doneBlock: {
                    picker, value, index in
                    
                    var dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy"
                    var new : String = dateFormatter.string(from: (value as! NSDate) as Date)
                    
                    obj_AddIncome.str_DueData = new
                    self.validationAddIncomeButton()
                    self.tbl_Main.reloadData()
                    return
                }, cancel: { ActionStringCancelBlock in return }, origin: tableView.superview!.superview)
                
                datePicker?.show()
                
                break
            case 3:
                
                self.performSegue(withIdentifier: "incomefreq", sender: self)
                
                break
                
            case 4:
              
                break
                
            default:
                break
            }
            
            
        }else if indexPath.section == 1{
            
            switch indexPath.row{
            case 0:
                break
                
            default:
                break
            }
        }
    }
}


//MARK: - UITextField Delegates -
extension AddIncomeViewController : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        boolEditingMode = false
        
        if((tf_NameOfIncome.text?.isEmpty)! && GlobalConstants.developerTest == false){
            
        }
        
        self.validationAddIncomeButton()
        tbl_Main.reloadData()
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //Set error message box
        
        if con_BottomErrorMessage?.constant == 0 {
            con_BottomErrorMessage?.constant = -100
            tbl_Main.reloadData()
        }
        
        if textField == tf_Amount && boolEditingMode == false{
            boolEditingMode = true
            
            tbl_Main.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.tf_Amount.becomeFirstResponder()
            })
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        self.view.endEditing(true)
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText:String = textField.text!
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        //Manage string with one dot and $ symbol starting character in string
        if textField == tf_Amount
        {
            if currentText.range(of:".") != nil && string == "."{
                return false
            }
            
            if updatedText == "$"{
                textField.text = ""
            }else{
                if updatedText.range(of:"$") != nil {
                    
                }else{
                    textField.text = "$\(updatedText )"
                    self.validationAddIncomeButton()
                    return false
                }
            }
        }
        self.validationAddIncomeButton()
        
        return true
    }

}


