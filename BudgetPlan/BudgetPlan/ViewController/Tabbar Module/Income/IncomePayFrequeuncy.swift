//
//  IncomePayFrequeuncy.swift
//  BudgetPlan

import UIKit

class IncomePayFrequeuncy: UIViewController {

    //Declaration tableview
    @IBOutlet weak var tbl_Main: UITableView!
    
    var arr_Main : NSMutableArray = ["One Time Only","Weekly","Bi-weekly","Monthly","Yearly"]
    
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
        navigationAppTitle(view : self, title : "pay",title2 : "frequency")
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

class IncomePayFrequeuncyViewObject: NSObject {
    var Str_Name : String = ""
    var str_Selected : String = ""
    
    var str_Image : String = ""
}


//MARK: - Tableview View Cell -
class IncomePayFrequeuncyViewCell : UITableViewCell{
    
    //Main Listing product
    @IBOutlet weak var lbl_Title: UILabel!
    
    @IBOutlet weak var img_IconRight: UIImageView!
}

// MARK: - Tableview Files -
extension IncomePayFrequeuncy : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_Main.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell_Identifier = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_Identifier, for:indexPath as IndexPath) as! IncomePayFrequeuncyViewCell
        
        cell.lbl_Title.text = arr_Main[indexPath.row] as! String
        
        cell.img_IconRight.isHidden = true
        if obj_AddIncome.str_Repeats == arr_Main[indexPath.row] as! String{
            cell.img_IconRight.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        obj_AddIncome.str_Repeats = arr_Main[indexPath.row] as! String
        tbl_Main.reloadData()
        
        self.navigationController?.popViewController(animated: true)
    }
}





