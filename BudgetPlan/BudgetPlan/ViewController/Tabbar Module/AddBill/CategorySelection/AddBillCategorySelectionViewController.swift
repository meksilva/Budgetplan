//
//  AddBillCategorySelectionViewController.swift
//  BudgetPlan

import UIKit

class AddBillCategorySelectionViewController: UIViewController {

    //Declaration tableview
    @IBOutlet weak var tbl_Main: UITableView!
    
    var arr_Main : NSMutableArray = ["Rent/Mortgage","Medical","Education","Daycare","Loan","Utility","Personal","Insurance","Fees","Taxes","Credit Card","Entertainment","Other"]
    
    var str_Type : String = ""
    var str_CategorySave : String = ""
    
    @IBOutlet weak var btn_Done: UIBarButtonItem!
    
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
        
        if str_Type == "direct"{
            str_CategorySave = (objAddNewBill?.str_AddNewCategory)!
        }else{
            str_CategorySave = obj_AddBill.str_Cateogry
        }
        
    }
    
    // MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func btn_Done(_ sender:Any){
        if str_Type == "direct"{
            objAddNewBill?.str_AddNewCategory = str_CategorySave
        }else{
            obj_AddBill.str_Cateogry = str_CategorySave
        }
        
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

class AddBillCategoryViewObject: NSObject {
    var Str_Name : String = ""
    var str_Selected : String = ""
    
    var str_Image : String = ""
}


//MARK: - Tableview View Cell -
class AddBillCategoryViewCell : UITableViewCell{
    
    //Main Listing product
    @IBOutlet weak var lbl_Title: UILabel!
    
    @IBOutlet weak var img_IconRight: UIImageView!
    @IBOutlet weak var img_IconLeft: UIImageView!
}

// MARK: - Tableview Files -
extension AddBillCategorySelectionViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_Main.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell_Identifier = "cell"

        let cell = tableView.dequeueReusableCell(withIdentifier: cell_Identifier, for:indexPath as IndexPath) as! AddBillCategoryViewCell
        
        cell.lbl_Title.text = arr_Main[indexPath.row] as! String
        
        cell.img_IconRight.isHidden = true
        
        if str_CategorySave == arr_Main[indexPath.row] as! String{
            cell.img_IconRight.isHidden = false
        }
        
        if arr_Main[indexPath.row] as! String == "Other" && str_CategorySave != ""{
            var bool_Match : Bool = false
            for i in (0..<arr_Main.count){
                if str_CategorySave == arr_Main[i] as! String{
                    bool_Match = true
                    break
                }
            }
            
            if bool_Match == false{
                cell.img_IconRight.isHidden = false
            }
        }
        
        if indexPath.row == 0{
            cell.img_IconLeft.image = UIImage.init(named: "cat_RentMortgage")
        }else{
            cell.img_IconLeft.image = UIImage.init(named: "cat_\(arr_Main[indexPath.row] as! String)")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Direct = Come from MyBudget Screen
        
        if arr_Main[indexPath.row] as! String == "Other"{
            let alertController = UIAlertController(title: "Enter new category name", message: "", preferredStyle: .alert)
        
            let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
                alert -> Void in
                
                let firstTextField = alertController.textFields![0] as UITextField

                if firstTextField.text! == ""{
                   firstTextField.text = "Other"
                }
                
                self.btn_Done.isEnabled = true
                self.str_CategorySave = firstTextField.text!
                self.tbl_Main.reloadData()
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
                (action : UIAlertAction!) -> Void in
                
            })
            
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter category Name"
            }
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        
        }else if arr_Main[indexPath.row] as! String == "Credit Card"{
            self.performSegue(withIdentifier: "account", sender: self)
        }else{
            
            self.str_CategorySave = arr_Main[indexPath.row] as! String
            btn_Done.isEnabled = true
        }
        tbl_Main.reloadData()
    }
}



