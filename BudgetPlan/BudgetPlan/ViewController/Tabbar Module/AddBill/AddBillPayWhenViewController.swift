//
//  AddBillPayWhenViewController.swift
//  BudgetPlan

import UIKit
import ActionSheetPicker_3_0

class AddBillPayWhenViewController: UIViewController {
    //Declaration tableview
    @IBOutlet weak var tbl_Main: UITableView!
    
    var arr_Main : NSMutableArray = ["Pay Equal Amount From Each Paycheck","Pay Full Amount From One Paycheck"]
    
    var str_Seleted : String = ""
    
    var str_Save : String = ""
    
    @IBOutlet weak var btn_Done: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
        
        if obj_AddBill.str_PayWhen != "Pay Equal Amount From Each Paycheck" && obj_AddBill.str_PayWhen != "Pay Full Amount From One Paycheck" && obj_AddBill.str_PayWhen != ""{
            str_Seleted = obj_AddBill.str_PayWhen
            arr_Main.add(obj_AddBill.str_PayWhen)
        }else if obj_AddBill.str_PayWhen == "Pay Equal Amount From Each Paycheck"{
            str_Seleted = "Pay Equal Amount From Each Paycheck"
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Other Files -
    func commanMethod(){
        
        //Set navigation bar title text
        navigationAppTitle(view : self, title : "pay",title2 : "schedule")
        
        str_Save = obj_AddBill.str_PayWhen
    }
    
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func btn_Done(_ sender:Any){
        obj_AddBill.str_PayWhen = str_Save
        self.navigationController?.popViewController(animated: true)
        
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


//MARK: - AddBill Object -

class AddBillPayWhenViewObject: NSObject {
    var Str_Name : String = ""
    var str_Selected : String = ""
    
    var str_Image : String = ""
}


//MARK: - Tableview View Cell -
class AddBillPayWhenViewCell : UITableViewCell{
    
    //Main Listing product
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Detail: UILabel!
    
    @IBOutlet weak var img_IconRight: UIImageView!
    @IBOutlet weak var img_IconLeft: UIImageView!
}

// MARK: - Tableview Files -
extension AddBillPayWhenViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_Main.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell_Identifier = "cell"
        
        if indexPath.row == 2 {
            cell_Identifier = "cell1"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_Identifier, for:indexPath as IndexPath) as! AddBillPayWhenViewCell
        
        cell.lbl_Title.text = arr_Main[indexPath.row] as! String
        
        cell.img_IconRight.isHidden = true
        
        if indexPath.row != 2{
            if arr_Main.count == 3 && indexPath.row == 1 {
                cell.img_IconRight.isHidden = false
            }else if str_Seleted == arr_Main[indexPath.row] as! String{
                cell.img_IconRight.isHidden = false
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  indexPath.row == 1 {
            
            var arr_List : Array = ["First Paycheck of the Month","Second Paycheck of the Month","Third Paycheck of the Month","Fourth Paycheck of the Month"]
            
            var Int_Selected : Int = 0
            
            for i in (0..<arr_List.count){
                if arr_List[i] == str_Save{
                    Int_Selected = i
                    break
                }
            }
            
            ActionSheetStringPicker.show(withTitle: "Select Type", rows: arr_List, initialSelection: Int_Selected, doneBlock: {
                picker, value, index in
                
                self.btn_Done.isEnabled = true
                self.str_Save = arr_List[value]
                
                if self.arr_Main.count == 3{
                    self.str_Seleted = self.str_Save
                    self.arr_Main.replaceObject(at: 2, with: self.str_Save)
                }else{
                    self.str_Seleted = self.str_Save
                    self.arr_Main.add(self.str_Save)
                }
                self.tbl_Main.reloadData()
                
                print("value = \(value)")
                print("index = \(index)")
                print("picker = \(picker)")
                return
            }, cancel: { ActionStringCancelBlock in return }, origin: tableView)
        }else if  indexPath.row == 0 {
            btn_Done.isEnabled = true
            
            str_Seleted = arr_Main[indexPath.row] as! String
            
            if self.arr_Main.count == 3{
                self.arr_Main.removeLastObject()
            }
            str_Save = str_Seleted
            
            tbl_Main.reloadData()
        }
    }
}






