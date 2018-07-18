//
//  HomeViewController.swift
//  BudgetPlan

import UIKit

class HomeViewController: UIViewController {

    //Collectionview declaration
    @IBOutlet weak var cv_HeaderSelection : UICollectionView!
    
    //Other declaationdeclaration
    var indexpath_Header : NSIndexPath = NSIndexPath(row: 0, section: 0)
    var arr_Header = ["Overview","My Bills","My Paychecks"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commanMethod()
        
        vw_HomeView = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Page view controller -
    var HomePageViewController: HomePageViewController? {
        didSet {
            HomePageViewController?.tutorialDelegate = self
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let HomePageViewController = segue.destination as? HomePageViewController {
            self.HomePageViewController = HomePageViewController
        }
    }
    

    
    //MARK: - Other Files -
    func commanMethod(){
        
        //Set navigation bar title text
        navigationAppTitle(view : self, title : "budget",title2 : "plan")
    }
    func moveOtherView(view : Int)  {
        switch view {
        case 1:
            //Move to Notification view

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "AddIncomeViewController") as! AddIncomeViewController
            view.boolBack = true
            self.navigationController?.pushViewController(view, animated: true)
            break
        case 2:
            //Move to Notification view
            self.performSegue(withIdentifier: "notification", sender: self)
            break
        case 3:
            //Move to Securty
            self.performSegue(withIdentifier: "security", sender: self)
            break
            
        default:
            
            break
        }
    }
    
    // MARK: - Button Event -
    @IBAction func btn_NavigationLeft(_ sender: Any) {
        toggleLeft()
    }
    @IBAction func btn_NavigationRight(_ sender: Any) {
        let view : MyBillsViewController = self.HomePageViewController?.orderedViewControllers[1] as! MyBillsViewController
        view.performSegue(withIdentifier: "filter", sender: self)
    }
    @IBAction func btn_NavigationRight2(_ sender: Any) {
        let view : MyPaychecksViewController = self.HomePageViewController?.orderedViewControllers[2] as! MyPaychecksViewController
        view.performSegue(withIdentifier: "filter", sender: self)
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

//MARK: - Pageview controller Delegate -
extension HomeViewController: HomePageViewControllerDelegate {
    
    func HomePageViewController(_ HomePageViewController: HomePageViewController, didUpdatePageCount count: Int) {
        
    }
    func HomePageViewController(_ HomePageViewController: HomePageViewController,
                                didUpdatePageIndex index: Int) {
        indexpath_Header = NSIndexPath(row: index, section: 0)
        self.cv_HeaderSelection.reloadData()
        
        HomePageViewController.scrollToViewController(index: index)
    }
    
}


//MARK: - Collection View -
extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arr_Header.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let str_Image : String = arr_Header[indexPath.row]
        let starWidth = str_Image.widthOfString(usingFont: UIFont(name:  GlobalConstants.font_OpenSans, size: 16)!) + 20
        
        return CGSize(width: starWidth, height: collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        var int_TotalSize : Int = 0
        for i in (0..<arr_Header.count){
            
            //Manage Height
            let str_Image : String = arr_Header[i]
            let starWidth = str_Image.widthOfString(usingFont: UIFont(name:  GlobalConstants.font_OpenSans, size: 16)!) + 20
            
            int_TotalSize = int_TotalSize + Int(starWidth)
        }
        //Calculation
        let int_WidthManage = Int(GlobalConstants.windowWidth) - int_TotalSize
        if int_WidthManage > 0 {
            return CGSize(width: CGFloat(int_WidthManage/2), height: collectionView.frame.size.height)
        }else{
            return CGSize(width: 0, height:0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let reusableView : UICollectionReusableView? = nil
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
            
            headerView.backgroundColor = UIColor.clear;
            return headerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
        
        return reusableView!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let lbl_Title : UILabel = cell.viewWithTag(100) as! UILabel
        let lbl_Image : UIImageView = cell.viewWithTag(101) as! UIImageView
        
        lbl_Title.text = arr_Header[indexPath.row]
        
        lbl_Title.textColor = UIColor.lightGray
        lbl_Image.isHidden = true
        
        if indexpath_Header.row == indexPath.row {
            lbl_Title.textColor = UIColor.init(red: 179/256, green: 191/256, blue: 195/256, alpha: 1)
            lbl_Image.isHidden = false
            
            if indexPath.row == 1{
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"icon_Filter"), style: .plain, target: self, action: #selector(btn_NavigationRight(_:)))
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
            }else if indexPath.row == 2{
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"icon_Filter"), style: .plain, target: self, action: #selector(btn_NavigationRight2(_:)))
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
            }else{
                self.navigationItem.rightBarButtonItem = nil
            }
        }else{
            lbl_Title.textColor = UIColor.init(red: 30/256, green: 176/256, blue: 229/256, alpha: 1)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        HomePageViewController?.scrollToPreviewsViewController(indexCall:indexPath.row)
        indexpath_Header = indexPath as NSIndexPath
        cv_HeaderSelection.reloadData()
    }
}


// MARK: - Side Bar Controller -
extension HomeViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}
