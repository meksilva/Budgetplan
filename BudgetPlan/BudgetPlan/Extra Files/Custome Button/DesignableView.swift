//
//  Designable.swift

import UIKit

@IBDesignable class DesignableView: UIView {

    
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderWidth;
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor;
        }
    }
    @IBInspectable var cornerradious: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerradious;
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
