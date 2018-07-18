//
//  IncomeCategoryList.swift
//  BudgetPlan

import UIKit

class IncomeCategoryList: UIViewController {

    //Declaration tableview
    @IBOutlet weak var tbl_Main: UITableView!
    
    var arr_Main : NSMutableArray = ["Salary","Contract Work","Bonus","Stocks/Bonds/Mutual Funds","Real Estate/Rental Income","Business ","Child Support","Retirement","Estate Income","Lottery","Taxes/Tax Return","Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Other Files -
    func commanMethod(){
        
        //Set navigation bar title text
        navigationAppTitle(view : self, title : "select",title2 : "category")
    }
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
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

class AddIncomeCategoryViewObject: NSObject {
    var Str_Name : String = ""
    var str_Selected : String = ""
    
    var str_Image : String = ""
}


//MARK: - Tableview View Cell -
class AddIncomeCategoryViewCell : UITableViewCell{
    
    //Main Listing product
    @IBOutlet weak var lbl_Title: UILabel!
    
    @IBOutlet weak var img_IconRight: UIImageView!
}

// MARK: - Tableview Files -
extension IncomeCategoryList : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_Main.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell_Identifier = "cell"

        let cell = tableView.dequeueReusableCell(withIdentifier: cell_Identifier, for:indexPath as IndexPath) as! AddIncomeCategoryViewCell
        
        cell.lbl_Title.text = arr_Main[indexPath.row] as! String
        
        cell.img_IconRight.isHidden = true
        if obj_AddIncome.str_Cateogry == arr_Main[indexPath.row] as! String{
            cell.img_IconRight.isHidden = false
        }
        
        if obj_AddIncome.str_Cateogry != ""{
             if indexPath.row == arr_Main.count - 1 {
                var bool_Value : Bool = false
                for i in (0..<arr_Main.count){
                    if obj_AddIncome.str_Cateogry == arr_Main[i] as! String{
                        bool_Value = true
                        break
                    }
                }
                
                if bool_Value == false{
                    cell.img_IconRight.isHidden = false
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == arr_Main.count - 1 {
            let alertController = UIAlertController(title: "Set Category", message: "", preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
                alert -> Void in
                
                let firstTextField = alertController.textFields![0] as UITextField
                
                if firstTextField.text != ""{
                    obj_AddIncome.str_Cateogry = firstTextField.text!
                    self.navigationController?.popViewController(animated: true)
                }else{
                    obj_AddIncome.str_Cateogry = "Other"
                    self.navigationController?.popViewController(animated: true)
                }
                
                print("firstName \(firstTextField.text), secondName")
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
                (action : UIAlertAction!) -> Void in
                
            })
            
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "category name"
            }

            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }else{
             obj_AddIncome.str_Cateogry = arr_Main[indexPath.row] as! String
            
             self.navigationController?.popViewController(animated: true)
            tbl_Main.reloadData()
        }
    }
}



