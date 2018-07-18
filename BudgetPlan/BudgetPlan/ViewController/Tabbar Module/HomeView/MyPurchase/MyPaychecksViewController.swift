//
//  MyPaychecksViewController.swift
//  BudgetPlan

import UIKit

class MyPaychecksViewController: UIViewController {

    //Declaration tableview
    @IBOutlet weak var tbl_Main: UITableView!
    
    var arr_Budget : NSMutableArray = []
    
    //Bool Declaration
    var bool_AddPayment : Bool = false
    
    //TextField declaration
    var tf_AddName : UITextField!
    var tf_AddAmount : UITextField!
    var btn_AddPaymentSave : UIButton!
    
    var cellSave : MyBudgetViewCell!
    
    //Textfild Declaration
    var tf_Amount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tbl_Main.reloadData()
    }

    //MARK : - Other Function -
    func commanMethod(){
        
        arr_Budget = []
        
        let obj = MyBudgetViewObject()
        obj.str_Date = "August 18, 2017"
        obj.str_Prize = "$2,550.00"
        obj.str_Bill = "4 bills to pay"
        obj.str_Total = "Left to spend: $1,760.09"
        obj.arr_Sub = []
        
        let objsub = MyBudgetViewObject()
        objsub.str_SubTitle = "IRS Taxes"
        objsub.str_SubPrize = "$50.00"
        objsub.str_SubType = "0"
        obj.arr_Sub.add(objsub)
        
        let objsub2 = MyBudgetViewObject()
        objsub2.str_SubTitle = "Serius Radio"
        objsub2.str_SubPrize = "$18.21"
        objsub2.str_SubMonth = "Monthly"
        objsub2.str_SubDueDate = "Due date: 11/13/17"
        objsub2.str_SubDueDateType = "2"
        objsub2.str_SubType = "1"
        obj.arr_Sub.add(objsub2)
        
        let objsub3 = MyBudgetViewObject()
        objsub3.str_SubTitle = "IRS Taxes"
        objsub3.str_SubPrize = "$50.00"
        objsub3.str_SubType = "0"
        obj.arr_Sub.add(objsub3)
        
        arr_Budget.add(obj)
        
        let obj1  = MyBudgetViewObject()
        obj1.arr_Sub = obj.arr_Sub
        obj1.str_Date = "August 20, 2017"
        obj1.str_Prize = "$1,050.00"
        obj1.str_Bill = "3 bills to pay"
        obj1.str_Total = "Left to spend: $760.09"
        arr_Budget.add(obj1)
                
    }
    func validationView() -> Bool{
        if((tf_Amount.text?.isEmpty)! ){
            
            return false
        }else if(objAddNewBill?.str_AddNewCategory == ""){
            
            return false
        }
        
        return true
    }
    
    
    //MARK: - Button event -
    @IBAction func btn_CancelAddPayment(_ sender:Any){
        bool_AddPayment = false
        tbl_Main.reloadData()
    }
    @IBAction func btn_AddPayment(_ sender:Any){
        bool_AddPayment = false
        tbl_Main.reloadData()
    }
    @IBAction func btn_AddCategoryChange(_ sender:Any){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "AddBillCategorySelectionViewController") as! AddBillCategorySelectionViewController
        view.str_Type = "direct"
        self.navigationController?.pushViewController(view, animated: true)
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


//MARK: - Filter Object -

class MyBudgetViewObject: NSObject {
    var str_Date : String = ""
    var str_Prize : String = ""
    var str_Bill : String = ""
    var str_Total : String = ""
    
    //Sub Detail
    var str_SubTitle : String = ""
    var str_SubPrize : String = ""
    var str_SubMonth : String = ""
    var str_SubDueDate : String = ""
    var str_SubDueDateType : String = ""
    var str_SubType : String = ""
    
    var arr_Sub : NSMutableArray = []
    
    //Add New Payment
    var str_AddNewDate : String = ""
    var str_AddNewBillCount : String = ""
    var str_AddNewCategory : String = ""
}

//MARK: - Tableview View Cell -
class MyBudgetViewCell : UITableViewCell{
    
    //Main Listing product
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_Prize: UILabel!
    @IBOutlet weak var lbl_Bill: UILabel!
    @IBOutlet weak var lbl_Total: UILabel!
    
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Month: UILabel!
    @IBOutlet weak var lbl_DueDate: UILabel!
    
     @IBOutlet weak var tbl_Sub: UITableView!
    
    //Header
    @IBOutlet weak var lbl_HeaderDate: UILabel!
    @IBOutlet weak var lbl_HeaderBillCount: UILabel!
    
    @IBOutlet weak var btn_HeaderCancel: UIButton!
    @IBOutlet weak var btn_AddPayment: UIButton!
    @IBOutlet weak var btn_AddCategoryChange: UIButton!
    
    @IBOutlet weak var lbl_Categroy: UILabel!
    
    @IBOutlet weak var tf_Name: UITextField!
    @IBOutlet weak var tf_Amount: UITextField!
    
    @IBOutlet weak var img_Category: UIImageView!
    @IBOutlet weak var img_CategoryBG: UIImageView!
}

// MARK: - Tableview Files -
extension MyPaychecksViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tbl_Main == tableView{
            let obj = arr_Budget[indexPath.row] as! MyBudgetViewObject
            
            var int_Value = 127
            int_Value = int_Value + (56 * obj.arr_Sub.count)
        
            return CGFloat(int_Value)
        }
        return 56
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        print(bool_AddPayment)
        print(tableView == tbl_Main)
        if(bool_AddPayment == true && tableView == tbl_Main){
            return 294
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tbl_Main == tableView{
            return arr_Budget.count
        }else{
            let obj = arr_Budget[tableView.tag] as! MyBudgetViewObject
            let int_Count : Int = obj.arr_Sub.count + 2
            
            return int_Count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        cellSave = tableView.dequeueReusableCell(withIdentifier: "section")as! MyBudgetViewCell
        
        cellSave.tf_Name.delegate = self
        cellSave.tf_Amount.delegate = self
        
        //Texteding
        cellSave.tf_Name.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        cellSave.tf_Amount.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        tf_Amount = cellSave.tf_Amount
        tf_Amount.delegate = self
        tf_Amount.keyboardType = UIKeyboardType.decimalPad
        
        if (tf_AddName == nil){
            tf_AddName = cellSave.tf_Name
            tf_AddAmount = cellSave.tf_Amount
            btn_AddPaymentSave = cellSave.btn_AddPayment
        }
        cellSave.tf_Amount.tag = 100
        
        cellSave.lbl_HeaderDate.text = objAddNewBill?.str_AddNewDate
        cellSave.lbl_HeaderBillCount.text = objAddNewBill?.str_AddNewBillCount
        cellSave.lbl_Categroy.text = objAddNewBill?.str_AddNewCategory
        
        cellSave.btn_AddPayment.addTarget(self, action: #selector(btn_AddPayment(_:)), for: UIControlEvents.touchUpInside)
        cellSave.btn_HeaderCancel.addTarget(self, action: #selector(btn_CancelAddPayment(_:)), for: UIControlEvents.touchUpInside)
        cellSave.btn_AddCategoryChange.addTarget(self, action: #selector(btn_AddCategoryChange(_:)), for: UIControlEvents.touchUpInside)
        
        //Validation
        if objAddNewBill?.str_AddNewCategory != "" && cellSave.tf_Amount.text != ""{
            cellSave.btn_AddPayment.alpha = 1.0
            cellSave.btn_AddPayment.isUserInteractionEnabled = true
        }else{
            cellSave.btn_AddPayment.alpha = 0.34
            cellSave.btn_AddPayment.isUserInteractionEnabled = false
        }
        
        //Category Hidden False
        if objAddNewBill?.str_AddNewCategory == ""{
            cellSave.img_Category.isHidden = true
            cellSave.img_CategoryBG.isHidden = true
        }else{
            cellSave.img_Category.isHidden = false
            cellSave.img_CategoryBG.isHidden = false
        }
        
        return cellSave;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell_Identifier = "main"
        if tbl_Main != tableView{
            if tbl_Main != tableView{
                let obj = arr_Budget[tableView.tag] as! MyBudgetViewObject
                let int_Count : Int = obj.arr_Sub.count + 1
                
                if indexPath.row == 0{
                    cell_Identifier = "header"
                }else if int_Count == indexPath.row{
                    cell_Identifier = "footer"
                }else{
                    let objSub = obj.arr_Sub[indexPath.row - 1] as! MyBudgetViewObject
                    
                    if objSub.str_SubType == "0"{
                        cell_Identifier = "cell"
                    }else{
                        cell_Identifier = "cell2"
                    }
                }
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_Identifier, for:indexPath as IndexPath) as! MyBudgetViewCell
      
        
        if tbl_Main == tableView{
            
            cell.tbl_Sub.dataSource = self
            cell.tbl_Sub.delegate = self
            cell.tbl_Sub.tag = indexPath.row
            cell.tbl_Sub.reloadData()
            
        }else{
            
            let obj = arr_Budget[tableView.tag] as! MyBudgetViewObject
            let int_Count : Int = obj.arr_Sub.count + 1
            
            if indexPath.row == 0{
                cell.lbl_Date.text = obj.str_Date
                cell.lbl_Prize.text = obj.str_Prize
                cell.lbl_Bill.text = obj.str_Bill
                cell.lbl_Total.text = obj.str_Total
            }else if int_Count == indexPath.row{
                cell_Identifier = "footer"
            }else{
                let objSub = obj.arr_Sub[indexPath.row - 1] as! MyBudgetViewObject
                
                
                if objSub.str_SubType == "0"{
                    cell.lbl_Title.text = objSub.str_SubTitle
                    cell.lbl_Prize.text = objSub.str_SubPrize
                    
                }else{
                    cell.lbl_Title.text = objSub.str_SubTitle
                    cell.lbl_Prize.text = objSub.str_SubPrize
                    cell.lbl_Month.text = objSub.str_SubMonth
                    cell.lbl_DueDate.text = objSub.str_SubDueDate
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView != tbl_Main {
            let obj = arr_Budget[tableView.tag] as! MyBudgetViewObject
            let int_Count : Int = obj.arr_Sub.count + 1
            if int_Count == indexPath.row{
                //Manage data set
                objAddNewBill = MyBudgetViewObject()
                objAddNewBill?.str_AddNewDate = obj.str_Date
                objAddNewBill?.str_AddNewBillCount = obj.str_Bill
                objAddNewBill?.str_AddNewCategory = ""
                if (tf_AddName != nil){
                    tf_AddName.text = ""
                    tf_AddAmount.text = ""
                    tf_Amount.text = ""
                }
                
                //Reload tableview
                bool_AddPayment = true
                tbl_Main.reloadData()
                
                let when = DispatchTime.now() + 0.2
                DispatchQueue.main.asyncAfter(deadline: when) {
                    //Tableview scroll to top
                    self.tbl_Main.setContentOffset(CGPoint.zero, animated: true)
                }
            }
        }
    }
}


//MARK: - UITextField Delegates -
extension MyPaychecksViewController : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tbl_Main.reloadData()
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
                    if validationView() == false{
                        cellSave.btn_AddPayment.alpha = 0.34
                        cellSave.btn_AddPayment.isUserInteractionEnabled = false
                    }else{
                        cellSave.btn_AddPayment.alpha = 1.0
                        cellSave.btn_AddPayment.isUserInteractionEnabled = true
                    }
                    
                    return false
                }
            }
        }
        
        if validationView() == false{
            cellSave.btn_AddPayment.alpha = 0.34
            cellSave.btn_AddPayment.isUserInteractionEnabled = false
        }else{
            cellSave.btn_AddPayment.alpha = 1.0
            cellSave.btn_AddPayment.isUserInteractionEnabled = true
        }
        
        return true
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
    }
}
