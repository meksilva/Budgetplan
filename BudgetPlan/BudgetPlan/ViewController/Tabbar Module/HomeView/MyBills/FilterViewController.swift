//
//  FilterViewController.swift
//  BudgetPlan

import UIKit

class FilterViewController: UIViewController {

    //Declaration tableview
    @IBOutlet weak var tbl_Main: UITableView!
    
    //Constant declartion
    @IBOutlet weak var con_CenterView : NSLayoutConstraint!
    
    var arr_Category : NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.con_CenterView.constant = 0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Other Function
    func commanMethod(){
        con_CenterView.constant = CGFloat(GlobalConstants.windowHeight)
        
        arr_Category = []
        
        var obj = FilterViewObject()
        obj.str_Cateogry = "Rent/Mortgage"
        obj.str_Image = "RentMortgage"
        obj.str_Selected = ""
        arr_Category.add(obj)
        obj = FilterViewObject()
        obj.str_Cateogry = "Medical"
        obj.str_Image = "Medical"
        obj.str_Selected = ""
        arr_Category.add(obj)
        obj = FilterViewObject()
        obj.str_Cateogry = "Education"
        obj.str_Image = "Education"
        obj.str_Selected = ""
        arr_Category.add(obj)
        obj = FilterViewObject()
        obj.str_Cateogry = "Daycare"
        obj.str_Image = "Daycare"
        obj.str_Selected = ""
        arr_Category.add(obj)
        obj = FilterViewObject()
        obj.str_Cateogry = "Loan"
        obj.str_Image = "Loan"
        obj.str_Selected = ""
        arr_Category.add(obj)
        obj = FilterViewObject()
        obj.str_Cateogry = "Utility"
        obj.str_Image = "Utility"
        obj.str_Selected = ""
        arr_Category.add(obj)
        obj = FilterViewObject()
        obj.str_Cateogry = "Personal"
        obj.str_Image = "Personal"
        obj.str_Selected = ""
        arr_Category.add(obj)
        obj = FilterViewObject()
        obj.str_Cateogry = "Insurance"
        obj.str_Image = "Personal"
        obj.str_Selected = ""
        arr_Category.add(obj)
        obj = FilterViewObject()
        obj.str_Cateogry = "Fees"
        obj.str_Image = "Fees"
        obj.str_Selected = ""
        arr_Category.add(obj)
        obj = FilterViewObject()
        obj.str_Cateogry = "Personal"
        obj.str_Image = "Personal"
        obj.str_Selected = ""
        arr_Category.add(obj)
        obj = FilterViewObject()
        obj.str_Cateogry = "Insurance"
        obj.str_Image = "Insurance"
        obj.str_Selected = ""
        arr_Category.add(obj)
        obj = FilterViewObject()
        obj.str_Cateogry = "Fees"
        obj.str_Image = "Fees"
        obj.str_Selected = ""
        arr_Category.add(obj)
        obj = FilterViewObject()
        obj.str_Cateogry = "Personal"
        obj.str_Image = "Personal"
        obj.str_Selected = ""
        arr_Category.add(obj)
        obj = FilterViewObject()
        obj.str_Cateogry = "Insurance"
        obj.str_Image = "Insurance"
        obj.str_Selected = ""
        arr_Category.add(obj)
        obj = FilterViewObject()
        obj.str_Cateogry = "Fees"
        obj.str_Image = "Fees"
        obj.str_Selected = ""
        arr_Category.add(obj)
        
    }

    //MARK: - Button Event -
    @IBAction func btn_Back(_ sender:Any){
        self.dismiss(animated: true, completion: nil)
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

class FilterViewObject: NSObject {
    var str_Cateogry : String = ""
    var str_Name : String = ""
    var str_Image : String = ""
    var str_Selected : String = ""
}

//MARK: - Tableview View Cell -
class FilterViewCell : UITableViewCell{
    
    //Main Listing product
    @IBOutlet weak var lbl_Title: UILabel!
    
    @IBOutlet weak var img_Icon: UIImageView!
    @IBOutlet weak var img_IconBG: UIImageView!
    @IBOutlet weak var img_Selected: UIImageView!
}

// MARK: - Tableview Files -
extension FilterViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }else  if section == 1 {
            return 34
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }else  if section == 1 {
            return arr_Category.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "section")as! FilterViewCell
            
            cell.lbl_Title.text = "(Select one or more categories to view)"
            
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_Identifier, for:indexPath as IndexPath) as! FilterViewCell
        
        if indexPath.section == 0 {

            if indexPath.row == 0{
                cell.lbl_Title.text = "Debt"
            }else if indexPath.row == 1{
                cell.lbl_Title.text = "Recurring Bills"
            }
        }else if indexPath.section == 1 {

            let obj : FilterViewObject = arr_Category[indexPath.row] as! FilterViewObject
            cell.lbl_Title.text = obj.str_Cateogry
            cell.img_Icon.image = UIImage.init(named: "cat_\(obj.str_Image)")
            
            cell.img_Selected.isHidden = false
            if obj.str_Selected == ""{
                cell.img_Selected.isHidden = true
            }
        }
        
         return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            
            let obj : FilterViewObject = arr_Category[indexPath.row] as! FilterViewObject
            
            if obj.str_Selected == ""{
                obj.str_Selected = "1"
            }else{
                obj.str_Selected = ""
            }
            arr_Category[indexPath.row] = obj
            tbl_Main.reloadData()
        }
    }
}

