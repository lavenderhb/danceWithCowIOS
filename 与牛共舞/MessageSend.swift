import Foundation.NSDate

class MessageSend {
    
    var memberId:String=""
    var backId:String=""
    var content:String=""
    var type:String=""
    
    init(memberId: String, backId: String, content: String,type:String) {
        self.memberId = memberId
        self.backId = backId
        self.content = content
        self.type=type
    }
    func getJsonString()->String{
        let dictionary:NSMutableDictionary=NSMutableDictionary()
        dictionary.setObject(self.memberId, forKey: "memberId")
        dictionary.setObject(self.backId, forKey: "backId")
        dictionary.setObject(self.content, forKey: "content")
        dictionary.setObject(self.type, forKey: "type")
        
        return getJSONStringFromDictionary(dictionary)
        
    }
    
    func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
        if (!NSJSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? NSJSONSerialization.dataWithJSONObject(dictionary, options: []) as NSData!
        let JSONString = NSString(data:data as NSData,encoding:NSUTF8StringEncoding)
        return JSONString! as String
        
    }
    
}
