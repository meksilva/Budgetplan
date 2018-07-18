//
//  AddBillViewController.swift
//  BudgetPlan

import UIKit
import ActionSheetPicker_3_0

class AddBillViewController: UIViewController,DismissBillViewDelegate {
    
    //Declaration tableview
    @IBOutlet weak var tbl_Main: UITableView!
    
    //Textfild Declaration
    var tf_Amount: UITextField!
    var tf_Name: UITextField!
    
    //Textview declaration
    var tv_Address: UITextView!
    
    //Button Declartion
    @IBOutlet weak var btn_AddBill : UIButton?
    
    //Constact declaration
    @IBOutlet weak var con_BottomErrorMessage : NSLayoutConstraint?
    
    //Other Declartion
    var boolBack : Bool = false
    var str_BillType : String = "Subscription/Recurring"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        //Set error message box
        con_BottomErrorMessage?.constant = -100
        tbl_Main.reloadData()
        
        self.validationAddIncomeButton()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - PopUp Delegate -
    func BillEvent(info: NSInteger) {
        if info == 1 {
            tf_Name.text = ""
            tf_Amount.text = ""
            tv_Address.text = ""
            self.commanMethod()
            self.tbl_Main.reloadData()
        } else if info == 2 {
            if boolBack == false {
                manageTabBarandSideBar()
            }else{
                Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(backToRoot), userInfo: nil, repeats: false)
            }
        }
    }
    
    //MARK: - Other Files -
    func commanMethod(){
    
        obj_AddBill.str_Cateogry = ""
        obj_AddBill.Str_Name = ""
        obj_AddBill.str_Type = str_BillType
        obj_AddBill.str_DueData = ""
        obj_AddBill.str_Repeats = ""
        obj_AddBill.str_Amount = ""
        obj_AddBill.str_PayWhen = ""
        
        if str_BillType != "Subscription/Recurring"{
            obj_AddBill.str_Repeats = " "
        }
        
        //Set navigation bar title text
        navigationAppTitle(view : self, title : "add",title2 : "bill")
        
        if boolBack == true {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    func validationAddIncomeButton(){
        btn_AddBill?.alpha = 0.5
        
        if tf_Amount != nil{
            if (tf_Amount.text != "") && obj_AddBill.str_PayWhen != "" {
                btn_AddBill?.alpha = 1.0
            }
        }
    }
    @objc func backToRoot(){
        self.navigationController?.popToRootViewController(animated: true)
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
        if (tf_Amount.text != "") && obj_AddBill.str_PayWhen != "" {
            //Remove $symbol in string and pass to other view
            var str_Amount = tf_Amount.text! as String
            str_Amount.remove(at: str_Amount.startIndex)
            
            let view = self.storyboard?.instantiateViewController(withIdentifier: "AddBillCompletePaymentViewController") as! AddBillCompletePaymentViewController
            view.delegate = self
            view.str_BusinessName = (tf_Name.text! == "") ? "Bill #1" : tf_Name.text! as NSString
            view.str_Prize = str_Amount as NSString
            view.modalPresentationStyle = .custom
            view.modalTransitionStyle = .crossDissolve
            self.present(view,animated:true,completion:nil);
        }else{
            con_BottomErrorMessage?.constant = 0
            tbl_Main.reloadData()
        }
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

class AddBillViewObject: NSObject {
    var str_Cateogry : String = ""
    var Str_Name : String = ""
    var str_Type : String = ""
    var str_DueData : String = ""
    var str_Repeats : String = ""
    var str_Amount : String = ""
    
    var str_PayWhen : String = ""
    
}


//MARK: - Tableview View Cell -
class AddBillViewCell : UITableViewCell{
    
    //Main Listing product
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Desciption: UILabel!
    @IBOutlet weak var lbl_TitleText: UILabel!
    @IBOutlet weak var lbl_Required: UILabel!
    
    @IBOutlet weak var tf_Main: UITextField!
    
    @IBOutlet weak var tv_Main: UITextView!
    
    @IBOutlet weak var img_IconRight: UIImageView!
    @IBOutlet weak var img_Validation: UIImageView!
    
    //No data cell
    @IBOutlet weak var switch_Remindar : UISwitch!
    
    //Button
    @IBOutlet weak var btn_EditingOn : UIButton!
}

// MARK: - Tableview Files -
extension AddBillViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Hide Recurrence filed when come to Debt option
        if str_BillType != "Subscription/Recurring" && indexPath.row == 4{
            return 0
        }
        
        //Note Section hight increase
        if indexPath.section == 1 && indexPath.row == 0{
            return 100
        }
        
        return 46
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 30
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 7
        }else  if section == 1 {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "section")as! AddBillViewCell
            
            cell.lbl_Title.text = "BILL INFORMATION"
            
            cell.layer.borderColor = UIColor.init(red: 230/256, green: 231/256, blue: 234/256, alpha: 1).cgColor
            cell.layer.borderWidth = 1.0
            cell.layer.masksToBounds = true
            
            return cell;
        }else if section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "section")as! AddBillViewCell
            
            cell.lbl_Title.text = "PAYMENT SETTINGS"
            
            cell.layer.borderColor = UIColor.init(red: 230/256, green: 231/256, blue: 234/256, alpha: 1).cgColor
            cell.layer.borderWidth = 1.0
            cell.layer.masksToBounds = true
            
            return cell;
        }else {
            return nil;
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell_Identifier = "cell"
        if indexPath.section == 0 {
            if indexPath.row == 1 || indexPath.row == 3 {
                cell_Identifier = "cellamount"
            }
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell_Identifier = "note"
            }else if indexPath.row == 1 {
                cell_Identifier = "cellswitch"
            }
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_Identifier, for:indexPath as IndexPath) as! AddBillViewCell
        
        if indexPath.section == 0 {
            cell.img_IconRight.isHidden = false
            cell.img_Validation.isHidden = true
            cell.lbl_Required.isHidden = true
            
            if indexPath.section == 0 {
               
                switch indexPath.row{
                case 0:
                    cell.lbl_Title.text = "Category"
                    cell.lbl_Desciption.text = obj_AddBill.str_Cateogry
                    
                    break
                case 1:
                    cell.lbl_Title.text = "Name"
                    tf_Name = cell.tf_Main
                    tf_Name.delegate = self
                    tf_Name.keyboardType = UIKeyboardType.default
                    
                    cell.img_IconRight.isHidden = true
                    
                    break
                case 2:
                    cell.lbl_Title.text = "Type"
                    cell.lbl_Desciption.text = obj_AddBill.str_Type
                    cell.img_IconRight.isHidden = true
                    
                    break
                    
                case 3:
                    if str_BillType == "Subscription/Recurring"{
                        cell.lbl_Title.text = "Amount"
                    }else{
                        cell.lbl_Title.text = "Amount"
                    }
                    tf_Amount = cell.tf_Main
                    tf_Amount.delegate = self
                    tf_Amount.keyboardType = UIKeyboardType.decimalPad
                    
                    cell.img_IconRight.isHidden = true
                    
                    if (con_BottomErrorMessage?.constant == 0 && (tf_Amount.text == "")){
                        cell.img_Validation.isHidden = false
                        cell.lbl_Required.isHidden = false
                    }
                    
                    break
                
                case 4:
                    cell.lbl_Title.text = "Recurrence"
                    cell.lbl_Desciption.text = obj_AddBill.str_Repeats

                    break
                    
                case 5:
                    cell.lbl_Title.text = "Due Date"
                    cell.lbl_Desciption.text = obj_AddBill.str_DueData
                    cell.img_IconRight.isHidden = true
                    
                    break
                    
                case 6:
                    cell.lbl_Title.text = "Pay Schedule"
                    cell.lbl_Desciption.text = obj_AddBill.str_PayWhen
                    
                    if (con_BottomErrorMessage?.constant == 0 && obj_AddBill.str_PayWhen == ""){
                        cell.img_Validation.isHidden = false
                        cell.lbl_Required.isHidden = false
                    }
                    
                    break
                    
                default: break
                    
                }
                
            }
        }else{
            switch indexPath.row{
            case 0:
                cell.lbl_Title.text = "Notes"
                cell.tv_Main.delegate = self
                tv_Address = cell.tv_Main
                
                break
            case 1:
                cell.lbl_Title.text = "Reminders"
                cell.switch_Remindar.layer.cornerRadius = 15
                
                break
                
            default:
                
                break
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row{
                case 0:
                self.performSegue(withIdentifier: "categoryselection", sender: self)
                break
            case 1:
                break
                
            case 5:
                
                let datePicker = ActionSheetDatePicker(title: "Date:", datePickerMode: UIDatePickerMode.date, selectedDate: NSDate() as Date!, doneBlock: {
                    picker, value, index in
                    
                    var dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy"
                    var new : String = dateFormatter.string(from: (value as! NSDate) as Date)
                    
                    obj_AddBill.str_DueData = new
                    self.tbl_Main.reloadData()
                
                    return
                }, cancel: { ActionStringCancelBlock in return }, origin: tableView.superview!.superview)
                
                
                datePicker?.show()
                
                break
            case 4:
                self.performSegue(withIdentifier: "billrepeattime", sender: self)
                break
                
            case 7:
                self.performSegue(withIdentifier: "paymentdone", sender: self)
                break
                
            case 6:
                self.performSegue(withIdentifier: "billpayoption", sender: self)
                break
                
            default:
                break
            }
            
            
        }else if indexPath.section == 1{
            
            switch indexPath.row{
            case 0:
                self.performSegue(withIdentifier: "billpayoption", sender: self)
                break
                
            default:
                break
            }
        }
    }
}


//MARK: - UITextField Delegates -
extension AddBillViewController : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.validationAddIncomeButton()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if con_BottomErrorMessage?.constant != -100{
            con_BottomErrorMessage?.constant = -100
            
            tbl_Main.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                
                if self.tf_Amount == textField {
                    self.tf_Amount.becomeFirstResponder()
                }else if self.tf_Name == textField {
                    self.tf_Name.becomeFirstResponder()
                }
            })
        }
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


//MARK: - UITextField Delegates -
extension AddBillViewController : UITextViewDelegate{
    
   
}


