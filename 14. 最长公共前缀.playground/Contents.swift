import UIKit

// 14. 最长公共前缀

//https://leetcode-cn.com/problems/longest-common-prefix/

//
class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        if strs.count == 0 { return "" }
        var ret = ""
        var minLen = Int.max
        for str in strs {
            minLen = min(minLen,str.count)
        }
        for i in 0..<minLen {
            for j in 1..<strs.count {
                if Array(strs[j])[i] != Array(strs[j-1])[i] {
                    return ret
                }
            }
            ret += String(Array(strs[0])[i])
        }
        return ret
    }
}
