//
//  SelfiePreviewViewController.swift
//  BudgetPlan

import UIKit

class SelfiePreviewViewController: UIViewController,UINavigationControllerDelegate {

    let picker = UIImagePickerController()
    
    //Declaration Label
    @IBOutlet weak var lbl_UserName: UILabel!
    @IBOutlet weak var lbl_OrTitle: UILabel!
    
    //Declaration uiimage
    @IBOutlet weak var img_SelectedImage: UIImageView!
    
    //Declaration UIView
    @IBOutlet weak var vw_DeletePhotoView: UIView!
    @IBOutlet weak var vw_CameraView: UIView!
    
    //Button
    @IBOutlet weak var btn_ContinueWithoutImage: UIButton!
    
    var str_Select : String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //Set navigation bar title text
        navigationAppTitle(view : self, title : "create",title2 : "account")
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Other Files -
    func commanMethod() {
        
        self.setfontTwo(view: self, title: "You look awesome, ", title2: (objUser?.str_UserName)!)
        
        // Imagepicker Setup
        picker.delegate = self
        
        vw_DeletePhotoView.isHidden = false
        
        vw_CameraView.isHidden = true
        btn_ContinueWithoutImage.isHidden = true
        lbl_OrTitle.isHidden = true
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(selectPhoto), userInfo: nil, repeats: false)
        
    }
    
    @objc func selectPhoto(){
        
        self .openCamra(id: "2")
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
            }else{
                vw_CameraView.isHidden = false
                btn_ContinueWithoutImage.isHidden = false
                lbl_OrTitle.isHidden = false
            }
        }
    }
    func setfontTwo(view : UIViewController,title : String,title2 : String){
        let str_Combination : String = title + title2 + "!"
        
        //Create Attribute object
        let attribute1 = [NSAttributedStringKey.foregroundColor: UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1), NSAttributedStringKey.font: UIFont(name: GlobalConstants.font_SFUITextRegular, size: 22)!]
        let attribute2 = [NSAttributedStringKey.foregroundColor: UIColor(red: 141 / 255.0, green: 181 / 255.0, blue: 78 / 255.0, alpha: 1), NSAttributedStringKey.font: UIFont(name: GlobalConstants.font_SFUITextRegular, size: 22)!]
        
        //Create range of String
        let myRange = NSRange(location: 0, length: title.characters.count)
        let myRange2 = NSRange(location: title.characters.count, length: title2.characters.count)
        let myRange3 = NSRange(location: title.characters.count + title2.characters.count, length: 1)
        
        //String object
        let attributedText = NSMutableAttributedString(string: str_Combination)
        
        //Set range in attribute string
        attributedText.setAttributes(attribute1, range: myRange)
        attributedText.setAttributes(attribute2, range: myRange2)
        attributedText.setAttributes(attribute1, range: myRange3)
        
        //Pass attribute string in uilabel
        lbl_UserName.attributedText = attributedText
    }
    
    
    @IBAction func btn_Back(_ sender:Any){
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func btn_Back2(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_Sure(_ sender:Any){
        let alert = UIAlertController(title: GlobalConstants.appName, message: "Select Photo Type", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default, handler: { (action) in
          self .openCamra(id: "1")
        }))
        
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (action) in
           self .openCamra(id: "2")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Button Event -
    @IBAction func btn_Retack(_ sender:Any){
        self.selectPhoto()
//        self.btn_Sure(self)
    }
    @IBAction func btn_Remove(_ sender:Any){
        vw_DeletePhotoView.isHidden = false
    }
    @IBAction func btn_Continue(_ sender:Any){
        
        self.performSegue(withIdentifier: "addbillfirsttime", sender: self)
    }
    @IBAction func btn_ContinueWithoutImage(_ sender:Any){
        
        self.performSegue(withIdentifier: "addbillfirsttime", sender: self)
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

extension SelfiePreviewViewController : UIImagePickerControllerDelegate{
    //MARK: - Imagepicker Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        vw_CameraView.isHidden = false
        btn_ContinueWithoutImage.isHidden = false
        lbl_OrTitle.isHidden = false
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        img_SelectedImage.image = chosenImage
        
        vw_DeletePhotoView.isHidden = true
        dismiss(animated:true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        vw_CameraView.isHidden = false
        btn_ContinueWithoutImage.isHidden = false
        lbl_OrTitle.isHidden = false
        
        dismiss(animated: true, completion: nil)
    }
}
