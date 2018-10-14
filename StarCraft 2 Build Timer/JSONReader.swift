import Foundation

typealias JsonDictionary = [String: Any]

struct JsonReader {
    
    // Static functions can be called without instances of the struct/class
    
    static func jsonArray(fromFile fileName: String) -> [JsonDictionary]? {
        
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else { return nil }
        
        let fileUrl = URL(fileURLWithPath: filePath)
        
        /*
         Error handling in Swift: functions marked with "throws" in their type signature need
         to be handled in a specific way. Throw errors when you need to give more information
         to the user of your function than a simple True/False return value or Optional return value.
         We won't need to use that frequently, at least in this class.
         */
        
        do {
            // Types are explicit so you can see what's happening
            let data: Data = try Data(contentsOf: fileUrl)
            let jsonAny: Any = try JSONSerialization.jsonObject(with: data, options: [])
            let jsonArray: [JsonDictionary]? = jsonAny as? [[String: Any]]
            return jsonArray
            
        } catch let error as NSError {
            print("Cannot Parse File: \(error)")
            return nil
        }
        
    }
    
}
