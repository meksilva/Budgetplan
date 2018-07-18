//
//  AddIncomeCompletedViewController.swift
//  BudgetPlan

import UIKit

class AddIncomeCompletedViewController: UIViewController  {
    
    weak var delegate : DismissBillViewDelegate? = nil
    
    //Constact declaration
    @IBOutlet weak var lbl_GetData : UILabel?
    
    @IBOutlet weak var btn_DoneIncome : UIButton?
    
    var boolBack : Bool = false
    
    var str_BusinessName : String = "david"
    var str_Prize : String = "100"
    var str_IncomeType : String = "income"
    var str_IncomeTime : String = "every two weeks"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colorAttribute = [NSAttributedStringKey.foregroundColor: UIColor.init(red: 0/256, green: 166/256, blue: 228/256, alpha: 1), NSAttributedStringKey.font: UIFont(name:  GlobalConstants.font_OpenSans, size: 16)!]
        let whiteAttribute = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font:UIFont(name:  GlobalConstants.font_OpenSans, size: 16)!]
        
        let part1 = NSMutableAttributedString(string: "You added a ", attributes: whiteAttribute)
        let part3 = NSMutableAttributedString(string: "\(str_IncomeTime) income of ", attributes: whiteAttribute)
        let part4 = NSMutableAttributedString(string: "$\(addCommaInPrize(value: Double(str_Prize)!)) ", attributes: colorAttribute)
        let part5 = NSMutableAttributedString(string: "from ", attributes: whiteAttribute)
        let part6 = NSMutableAttributedString(string: "\"\(str_BusinessName as String)\"", attributes: whiteAttribute)
        
        let combination = NSMutableAttributedString()
        
        combination.append(part1)
        combination.append(part3)
        combination.append(part4)
        combination.append(part5)
        combination.append(part6)
        
        lbl_GetData?.attributedText = combination
        
        //First time add income or edit income
        if boolBack == false{
            btn_DoneIncome?.setTitle("Continue to bills & expenses", for: .normal)
        }else{
            btn_DoneIncome?.setTitle("I'm done", for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Button Event -
    @IBAction func btn_AnotherBill(_ sender:Any){
        self .dismiss(animated: true) {
            self.delegate?.BillEvent(info: 1)
        }
        
    }
    @IBAction func btn_Done(_ sender:Any){
        self .dismiss(animated: true) {
            self.delegate?.BillEvent(info: 2)
        }
        
    }
    @IBAction func btn_Continue(_ sender:Any){
        self .dismiss(animated: true) {
            self.delegate?.BillEvent(info: 0)
        }
        
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

