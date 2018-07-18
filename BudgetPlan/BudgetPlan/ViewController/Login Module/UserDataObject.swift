//
//  UserDataObject.swift

import UIKit

class UserDataObject: NSObject,NSCoding  {
    //NSCoding
    
    var str_Email : String = ""
    var str_TouchId : String = ""
    var str_Password : String = ""
    var str_UserName : String = ""
    
    
    init(str_Email : String,str_TouchId : String,str_Password : String,str_UserName : String) {
        self.str_Email = str_Email as String
        self.str_TouchId = str_TouchId as String
        self.str_Password = str_Password as String
        self.str_UserName = str_UserName as String
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let str_Email = aDecoder.decodeObject(forKey: "str_Email") as! String
        let str_TouchId = aDecoder.decodeObject(forKey: "str_TouchId") as! String
        let str_Password = aDecoder.decodeObject(forKey: "str_Password") as! String
        let str_UserName = aDecoder.decodeObject(forKey: "str_UserName") as! String
        
        self.init(str_Email: str_Email as String,
                  str_TouchId: str_TouchId as String,
                  str_Password: str_Password as String,
                  str_UserName: str_UserName as String)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(str_Email, forKey: "str_Email")
        aCoder.encode(str_TouchId, forKey: "str_TouchId")
        aCoder.encode(str_Password, forKey: "str_Password")
        aCoder.encode(str_UserName, forKey: "str_UserName")
    }
    
}





