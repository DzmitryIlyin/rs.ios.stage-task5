import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        
        if message.count < 1 || message.count > 60 {
            return message
        }
        
        let allowedCharaters = CharacterSet.lowercaseLetters.union(CharacterSet.decimalDigits).union(CharacterSet(charactersIn: "[]"))
        
        if !CharacterSet(charactersIn: message).isSubset(of: allowedCharaters) {
            return message
        }
        
        var msg = message
        
        let regex = try! NSRegularExpression(pattern: "(\\d+)?(?>\\[(\\w*)\\])")
        
        var msgRange = NSRange(msg.startIndex..<msg.endIndex, in: msg)
        
        while(regex.matches(in: msg, options: [], range: msgRange).count > 0) {
            
            let matches = regex.matches(in: msg, options: [], range: msgRange)
            
            let match = matches.first!
            
            var matchReplacement = ""
            
            var completeMatch = ""
            if let substringRange = Range(match.range(at: 0), in: msg) {
                completeMatch = String(msg[substringRange])
            }
            
            var numberMatch = 1
            if let substringRange = Range(match.range(at: 1), in: msg) {
                numberMatch = Int(msg[substringRange]) ?? 0
            }
            
            var wordMatch = ""
            if let substringRange = Range(match.range(at: 2), in: msg) {
                wordMatch = String(msg[substringRange])
            }
            
            if numberMatch > 300 {
                return message
            }
            
            for _ in 0..<numberMatch {
                matchReplacement += wordMatch
            }
            
            msg = msg.replacingOccurrences(of: completeMatch, with: matchReplacement, options: [], range: nil)
            msgRange = NSRange(msg.startIndex..<msg.endIndex, in: msg)
        }
        return msg
    }
    
}
