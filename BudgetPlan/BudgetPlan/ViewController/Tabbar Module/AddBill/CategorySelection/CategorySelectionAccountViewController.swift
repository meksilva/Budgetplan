//
//  CategorySelectionAccountViewController.swift
//  BudgetPlan

import UIKit



class CategorySelectionAccountViewController: UIViewController {
    
    //Declaration tableview
    @IBOutlet weak var tbl_Main: UITableView!
    
    var arr_Main : NSMutableArray = []
    var arr_Sub : NSMutableArray = []
    
    var str_Type : String = ""
    
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
        navigationAppTitle(view : self, title : "select",title2 : "account")
        
        var obj = CategoryAccountViewObject()
        obj.Str_Name = "American Express"
        obj.str_Image = ""
        arr_Main.add(obj)
        obj = CategoryAccountViewObject()
        obj.Str_Name = "Bank of America"
        obj.str_Image = ""
        arr_Main.add(obj)
        obj = CategoryAccountViewObject()
        obj.Str_Name = "Citibank"
        obj.str_Image = ""
        arr_Main.add(obj)
        obj = CategoryAccountViewObject()
        obj.Str_Name = "Chase"
        obj.str_Image = ""
        arr_Main.add(obj)
        obj = CategoryAccountViewObject()
        obj.Str_Name = "Capital One"
        obj.str_Image = ""
        arr_Main.add(obj)
        obj = CategoryAccountViewObject()
        obj.Str_Name = "Discover"
        obj.str_Image = ""
        arr_Main.add(obj)
        obj = CategoryAccountViewObject()
        obj.Str_Name = "Fifth Third Bank"
        obj.str_Image = ""
        arr_Main.add(obj)
        
        
        obj = CategoryAccountViewObject()
        obj.Str_Name = "Macy’s"
        obj.str_Image = ""
        arr_Sub.add(obj)
        obj = CategoryAccountViewObject()
        obj.Str_Name = "Nordstrom"
        obj.str_Image = ""
        arr_Sub.add(obj)
        obj = CategoryAccountViewObject()
        obj.Str_Name = "Target"
        obj.str_Image = ""
        arr_Sub.add(obj)
        obj = CategoryAccountViewObject()
        obj.Str_Name = "Express"
        obj.str_Image = ""
        arr_Sub.add(obj)
        
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


//MARK: - CategoryAccount Object -

class CategoryAccountViewObject: NSObject {
    var Str_Name : String = ""
    
    var str_Image : String = ""
}


//MARK: - Tableview View Cell -
class CategoryAccountViewCell : UITableViewCell{
    
    //Main Listing product
    @IBOutlet weak var lbl_Title: UILabel!
    

    @IBOutlet weak var img_Icon: UIImageView!
}

// MARK: - Tableview Files -
extension CategorySelectionAccountViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
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
            return arr_Main.count
        }else  if section == 1 {
            return arr_Sub.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "section")as! CategoryAccountViewCell
            
            cell.lbl_Title.text = "BILL INFORMATION"
            
            cell.layer.borderColor = UIColor.init(red: 230/256, green: 231/256, blue: 234/256, alpha: 1).cgColor
            cell.layer.borderWidth = 1.0
            cell.layer.masksToBounds = true
            
            return cell;
        }else if section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "section")as! CategoryAccountViewCell
            
            cell.lbl_Title.text = "DEPARTMENT STORES"
            
            cell.layer.borderColor = UIColor.init(red: 230/256, green: 231/256, blue: 234/256, alpha: 1).cgColor
            cell.layer.borderWidth = 1.0
            cell.layer.masksToBounds = true
            
            return cell;
        }else {
            return nil;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell_Identifier = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_Identifier, for:indexPath as IndexPath) as! CategoryAccountViewCell
        
        cell.lbl_Title.text = arr_Main[indexPath.row] as? String
       
        if indexPath.section == 0{
            let obj : CategoryAccountViewObject = arr_Main[indexPath.row] as! CategoryAccountViewObject
            
            cell.lbl_Title.text = obj.Str_Name
            
        }else if indexPath.section == 1{
            let obj : CategoryAccountViewObject = arr_Sub[indexPath.row] as! CategoryAccountViewObject
            
            cell.lbl_Title.text = obj.Str_Name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.performSegue(withIdentifier: "recurrence", sender: self)
       
    }
}



