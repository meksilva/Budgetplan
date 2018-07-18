//
//  MyBillsViewController.swift
//  BudgetPlan


import UIKit

class MyBillsViewController: UIViewController {

    //Declaration tableview
    @IBOutlet weak var tbl_Main: UITableView!
    
    var arr_FixeDebt : NSMutableArray = []
    var arr_RecurringSub : NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Other Methods -
    func commanMethod(){
        arr_FixeDebt = []
        
        var obj = MyBillsViewObject()
        obj.Str_Name = "IRS Taxes"
        obj.str_Prize = "$500.00"
        arr_FixeDebt.add(obj)
        obj = MyBillsViewObject()
        obj.Str_Name = "Mom & Dad"
        obj.str_Prize = "$100.00"
        arr_FixeDebt.add(obj)
        
        arr_RecurringSub = []
        var obj2 = MyBillsViewObject()
        obj2.Str_Name = "Serius Radio"
        obj2.str_Prize = "$18.21"
        obj2.str_Month = "Monthly"
        obj2.str_DueDate = "Due Date: in 2 days"
        arr_RecurringSub.add(obj2)
        obj2 = MyBillsViewObject()
        obj2.Str_Name = "Fatcow Hosting"
        obj2.str_Prize = "$99.00"
        obj2.str_Month = "Yearly"
        obj2.str_DueDate = "Due Date: on 11/22/17"
        arr_RecurringSub.add(obj2)
        
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

class MyBillsViewObject: NSObject {
    var str_Cateogry : String = ""
    var Str_Name : String = ""
    var str_Prize : String = ""
    var str_Month : String = ""
    var str_DueDate : String = ""
}


//MARK: - Tableview View Cell -
class MyBillsViewCell : UITableViewCell{
    
    //Main Listing product
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    @IBOutlet weak var lbl_Prize: UILabel!
    @IBOutlet weak var lbl_Month: UILabel!
    @IBOutlet weak var lbl_DueDate: UILabel!
}

// MARK: - Tableview Files -
extension MyBillsViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 25
    }
    
    func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return arr_FixeDebt.count
        }else  if section == 1 {
            return arr_RecurringSub.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "section")as! MyBillsViewCell
            
            cell.lbl_Title.text = "FIXED DEBT BALANCES"
            cell.lbl_Description.text = "(Total: $12,455.34)"
            
            cell.layer.borderColor = UIColor.init(red: 230/256, green: 231/256, blue: 234/256, alpha: 1).cgColor
            cell.layer.borderWidth = 1.0
            cell.layer.masksToBounds = true
            
            return cell;
        }else if section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "section")as! MyBillsViewCell
            
            cell.lbl_Title.text = "RECURRING SUBSCRIPTIONS"
            cell.lbl_Description.text = "(Total: 12 Bills)"
            
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
        if indexPath.section == 1 {
           cell_Identifier = "cell2"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_Identifier, for:indexPath as IndexPath) as! MyBillsViewCell
    
        if indexPath.section == 0 {
            
            let obj : MyBillsViewObject = arr_FixeDebt[indexPath.row] as! MyBillsViewObject
            
            cell.lbl_Title.text = obj.Str_Name
            cell.lbl_Prize.text = obj.str_Prize
            
        }else if indexPath.section == 1 {
            
            let obj : MyBillsViewObject = arr_RecurringSub[indexPath.row] as! MyBillsViewObject
           
            cell.lbl_Title.text = obj.Str_Name
            cell.lbl_Prize.text = obj.str_Prize
            cell.lbl_Month.text = obj.str_Month
            cell.lbl_DueDate.text = obj.str_DueDate
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if indexPath.section == 0 {
            self .performSegue(withIdentifier: "debt", sender: nil)
         }else if indexPath.section == 1 {
            self .performSegue(withIdentifier: "REC", sender: nil)
        }
        
    }
}
