//
//  AddBillCompletePaymentViewController.swift
//  BudgetPlan

import UIKit

protocol DismissBillViewDelegate: class {
    func BillEvent(info: NSInteger)
}

class AddBillCompletePaymentViewController: UIViewController {

    weak var delegate : DismissBillViewDelegate? = nil
    
    //Constact declaration
    @IBOutlet weak var lbl_GetData : UILabel?
    
    var str_BusinessName : NSString = "david"
    var str_Prize : NSString = "100"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let yourOtherAttributes = [NSAttributedStringKey.foregroundColor: UIColor.init(red: 0/256, green: 166/256, blue: 228/256, alpha: 1), NSAttributedStringKey.font: UIFont(name:  GlobalConstants.font_OpenSans, size: 16)!]
        let yourAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font:UIFont(name:  GlobalConstants.font_OpenSans, size: 16)!]
        
        let partOne = NSMutableAttributedString(string: "You will pay ", attributes: yourAttributes)
        let partTwo = NSMutableAttributedString(string: "$\(addCommaInPrize(value: Double(str_Prize as String)!))", attributes: yourOtherAttributes)
        let partThree = NSMutableAttributedString(string: " from each paycheck towards your ", attributes: yourAttributes)
        let partForth = NSMutableAttributedString(string: "\"\(str_BusinessName as String)\"", attributes: yourOtherAttributes)
        let partTFifth = NSMutableAttributedString(string: " monthly bill ", attributes: yourAttributes)
        
        let combination = NSMutableAttributedString()
        
        combination.append(partOne)
        combination.append(partTwo)
        combination.append(partThree)
        combination.append(partForth)
        combination.append(partTFifth)
        
        lbl_GetData?.attributedText = combination
        
        // Do any additional setup after loading the view.
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
        
//        dismiss(animated: true)
        
    }
    @IBAction func btn_Done(_ sender:Any){
        self .dismiss(animated: true) {
            self.delegate?.BillEvent(info: 2)
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
