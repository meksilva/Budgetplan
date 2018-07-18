//
//  OverViewViewController.swift
//  BudgetPlan

import UIKit
import ListPlaceholder
import FTImageViewer

class OverViewViewController: UIViewController,UINavigationControllerDelegate {

    //Declaration tableview
    @IBOutlet weak var tbl_Main: UITableView!
    
    //Declaration imageview
    @IBOutlet weak var img_User: UIImageView!
    
    var arr_Card : NSMutableArray = []
    
    var bool_NoData : Bool = false
    
    let picker = UIImagePickerController()
    
    @IBOutlet var vw_Tbl_Main : UIView!
    @IBOutlet var vw_Header : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
        
    }
    override func viewWillLayoutSubviews() {
        self.tbl_Main.showLoader()
        self.vw_Tbl_Main.showLoader()
        self.vw_Header.showLoader()
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.removeLoader), userInfo: nil, repeats: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Other Function
    @objc func removeLoader(){
        self.tbl_Main.hideLoader()
        self.vw_Tbl_Main.hideLoader()
        self.vw_Header.hideLoader()
    }
    func commanMethod(){
        
        // Imagepicker Setup
        picker.delegate = self
        
        arr_Card = []
        
        var obj = OverViewViewObject()
        obj.str_CardName = "American Express"
        obj.str_Prize = "$50.00"
        obj.str_DueDate = "PAST DUE"
        obj.str_DueDateStatus = "1"
        arr_Card.add(obj)
        obj = OverViewViewObject()
        obj.str_CardName = "Bank of America"
        obj.str_Prize = "$350.00"
        obj.str_DueDate = "Due Date: in 4 days"
        obj.str_DueDateStatus = "2"
        arr_Card.add(obj)
        obj = OverViewViewObject()
        obj.str_CardName = "Citibank"
        obj.str_Prize = "$475.50"
        obj.str_DueDate = "Due Date: on 11/13/17"
        obj.str_DueDateStatus = "0"
        arr_Card.add(obj)
        obj = OverViewViewObject()
        obj.str_CardName = "Little Sprouts"
        obj.str_Prize = "$99.00"
        obj.str_DueDate = "Due Date: on 11/14/17"
        obj.str_DueDateStatus = "0"
        arr_Card.add(obj)
        obj = OverViewViewObject()
        obj.str_CardName = "Citibank"
        obj.str_Prize = "$475.50"
        obj.str_DueDate = "Due Date: on 11/13/17"
        obj.str_DueDateStatus = "0"
        arr_Card.add(obj)
        obj = OverViewViewObject()
        obj.str_CardName = "Little Sprouts"
        obj.str_Prize = "$99.00"
        obj.str_DueDate = "Due Date: on 11/14/17"
        obj.str_DueDateStatus = "0"
        arr_Card.add(obj)
        obj = OverViewViewObject()
        obj.str_CardName = "Citibank"
        obj.str_Prize = "$475.50"
        obj.str_DueDate = "Due Date: on 11/13/17"
        obj.str_DueDateStatus = "0"
        arr_Card.add(obj)
        obj = OverViewViewObject()
        obj.str_CardName = "Little Sprouts"
        obj.str_Prize = "$99.00"
        obj.str_DueDate = "Due Date: on 11/14/17"
        obj.str_DueDateStatus = "0"
        arr_Card.add(obj)
        obj = OverViewViewObject()
        obj.str_CardName = "Little Sprouts"
        obj.str_Prize = "$99.00"
        obj.str_DueDate = "Due Date: on 11/14/17"
        obj.str_DueDateStatus = "0"
        arr_Card.add(obj)
        
    }
    func openCamra(id : String){
        if id == "1"{
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
            
        }else{
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                
                self.picker.sourceType = .camera
                self.picker.allowsEditing = false
                self.picker.cameraDevice = .front
                self.present(self.picker, animated: true, completion: nil)
            }
        }
    }
    
    
    // MARK: - Button Event -
    @IBAction func btn_AddBillOrPayCheck(_ sender: Any){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "AddBillSelectionBillViewController") as! AddBillSelectionBillViewController
            view.boolBack = true
            self.navigationController?.pushViewController(view, animated: true)
    }
    
    @IBAction func btn_PhotoClick(_ sender:Any){
        let alert = UIAlertController(title: GlobalConstants.appName, message:nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.addAction(UIAlertAction(title: "Take a New Profile Picture", style: UIAlertActionStyle.default, handler: { (action) in
            self .openCamra(id: "2")
        }))
        
        alert.addAction(UIAlertAction(title: "Select a New Profile Picture", style: UIAlertActionStyle.default, handler: { (action) in
            self .openCamra(id: "1")
        }))
        
        alert.addAction(UIAlertAction(title: "View Profile Picture", style: UIAlertActionStyle.default, handler: { (action) in
            
            //Create arr for Slide image post to FTImageviewer
            var imageArray : [String] = []
//            for i in 0...1{
                imageArray += ["http://nerfmtti.nic.in/images/test.jpg"]
//            }
            
            //Create arr for frame with all images position
            var views = [UIView]()
//            for _ in 0...1 {
                views.append(self.img_User)
//            }
            
            //Call method present imageviewer
            FTImageViewer.showImages(imageArray, atIndex: 0, fromSenderArray: views)
        }))
    
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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

extension OverViewViewController : UIImagePickerControllerDelegate{
    //MARK: - Imagepicker Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        img_User.image = chosenImage
        
        dismiss(animated:true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
}


//MARK: - Filter Object -

class OverViewViewObject: NSObject {
    var str_CardName : String = ""
    var str_DueDate : String = ""
    var str_DueDateStatus : String = ""
    var str_Prize : String = ""
    var str_Image : String = ""
}

//MARK: - Tableview View Cell -
class OverViewViewCell : UITableViewCell{
    
    //Main Listing product
    @IBOutlet weak var lbl_CardName: UILabel!
    @IBOutlet weak var lbl_DueDate: UILabel!
    @IBOutlet weak var lbl_Prize: UILabel!
    
    @IBOutlet weak var lbl_SectionTilte: UILabel!
    
    @IBOutlet weak var img_Card: UIImageView!
    
    
}

// MARK: - Tableview Files -
extension OverViewViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if bool_NoData == true{
            return 230
        }
        
        return 46
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if bool_NoData == true{
            return 0
        }
        
        return 25
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        if bool_NoData == true{
            return 1
        }
        
        return arr_Card.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            
            if bool_NoData == true{
                return nil
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "section")as! OverViewViewCell
            
            cell.lbl_SectionTilte.text = "DUE DATES APPROACHING"
            
            
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
        if bool_NoData == true {
            cell_Identifier = "nodata"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_Identifier, for:indexPath as IndexPath) as! OverViewViewCell
        
        if bool_NoData == false {

            let obj : OverViewViewObject = arr_Card[indexPath.row] as! OverViewViewObject

            cell.lbl_CardName.text = obj.str_CardName
            cell.lbl_Prize.text = obj.str_Prize
            cell.lbl_DueDate.text = obj.str_DueDate

            //Manage due data color
            switch (Int(obj.str_DueDateStatus)){
            case 0?:
                  cell.lbl_DueDate.textColor = UIColor.black
                break
            case 1?:
                    cell.lbl_DueDate.textColor = UIColor.init(red: 197/256, green: 46/256, blue: 66/256, alpha: 1)
                    break
            case 2?:
                    cell.lbl_DueDate.textColor = UIColor.init(red: 242/256, green: 103/256, blue: 34/256, alpha: 1)
                    break
                default:
                    break
            }

            cell.img_Card.image = UIImage.init(named: "ic_\(indexPath.row+1)")

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

