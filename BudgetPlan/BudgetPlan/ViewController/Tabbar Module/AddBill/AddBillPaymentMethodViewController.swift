//
//  AddBillPaymentMethodViewController.swift
//  BudgetPlan

import UIKit

class AddBillPaymentMethodViewController: UIViewController {

    //Declaration tableview
    @IBOutlet weak var tbl_Main: UITableView!
    
    var arr_Main : NSMutableArray = ["American Express","Bank of America","Citybank","Discover","Fifth Third Bank"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

class AddBillPaymentViewObject: NSObject {
    var Str_Name : String = ""
    var str_Selected : String = ""
    
    var str_Image : String = ""
}


//MARK: - Tableview View Cell -
class AddBillPaymentViewCell : UITableViewCell{
    
    //Main Listing product
    @IBOutlet weak var lbl_Title: UILabel!
    
    @IBOutlet weak var img_IconRight: UIImageView!
    @IBOutlet weak var img_IconLeft: UIImageView!
}

// MARK: - Tableview Files -
extension AddBillPaymentMethodViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_Main.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell_Identifier = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_Identifier, for:indexPath as IndexPath) as! AddBillPaymentViewCell
        
        cell.lbl_Title.text = arr_Main[indexPath.row] as! String
        
        cell.img_IconRight.isHidden = true
        if obj_AddBill.Str_Name == arr_Main[indexPath.row] as! String{
            cell.img_IconRight.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        obj_AddBill.Str_Name = arr_Main[indexPath.row] as! String
        tbl_Main.reloadData()
    }
}




