//
//  IncomeSideViewController.swift
//  BudgetPlan

import UIKit

class IncomeSideViewController: UIViewController {

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
        navigationAppTitle(view : self, title : "income",title2 : " ")
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
class IncomeViewCell : UITableViewCell{
    
    
    @IBOutlet weak var lbl_Title : UILabel!
    @IBOutlet weak var lbl_Desc : UILabel!
    @IBOutlet weak var lbl_Prize : UILabel!
    
    
    @IBOutlet weak var img_Icon : UIImageView!
}



// MARK: - Tableview Files -
extension IncomeSideViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell_Identifier = "cell"


        let cell = tableView.dequeueReusableCell(withIdentifier: cell_Identifier, for:indexPath as IndexPath) as! IncomeViewCell

        if indexPath.row == 0{
            cell.lbl_Title.text = "34 Main Street"
            cell.lbl_Desc.text = "Monthly"
            cell.lbl_Prize.text = "$2,000.00"
        }else  if indexPath.row == 1{
            cell.lbl_Title.text = "Company Name"
            cell.lbl_Desc.text = "Bi-Weekly"
            cell.lbl_Prize.text = "$1,000.00"
        }
        
        return cell
    }
    
}

