import UIKit

// https://leetcode-cn.com/problems/first-unique-character-in-a-string/

class Solution {
    func firstUniqChar(_ s: String) -> Int {
        var arr = Array<Int>(repeating:0, count:26)
        let a = Int("a".unicodeScalars.first!.value)
        for c in Array(s) {
            let val = Int(c.unicodeScalars.first!.value)-a
            arr[val] += 1
        }
        for (i,c) in Array(s).enumerated() {
            let val = Int(c.unicodeScalars.first!.value)-a
            if arr[val] == 1 {
                return i
            }
        }
        return -1
    }
}
