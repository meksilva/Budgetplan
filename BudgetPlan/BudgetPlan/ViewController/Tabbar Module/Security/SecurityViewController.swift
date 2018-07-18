//
//  SecurityViewController.swift
//  BudgetPlan

import UIKit

class SecurityViewController: UIViewController {

    //Declaration tableview
    @IBOutlet weak var tbl_Main: UITableView!
    
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
        navigationAppTitle(view : self, title : "security",title2 : " ")
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

//MARK: - Tableview View Cell -
class SecurityViewCell : UITableViewCell{
    
    //No data cell
    @IBOutlet weak var switch_Notification : UISwitch!
    
    
    @IBOutlet weak var lbl_Title : UILabel!
}



// MARK: - Tableview Files -
extension SecurityViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell_Identifier = "cell"

        if indexPath.row == 1{
            cell_Identifier = "cellswitch"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_Identifier, for:indexPath as IndexPath) as! SecurityViewCell

        if indexPath.row == 0{
            cell.lbl_Title.text = "Reset Password"
        }else if indexPath.row == 1{
            cell.switch_Notification.layer.cornerRadius = 15
        }
        
        return cell
    }
    
}

