import UIKit

// 242. Valid Anagram

// https://leetcode-cn.com/problems/valid-anagram/


// 想到了排序算法，就不写了

// 看了答案的hash算法  https://leetcode-cn.com/problems/valid-anagram/solution/you-xiao-de-zi-mu-yi-wei-ci-by-leetcode/
// 空间O1，因为最多就26个字母
class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        if s.count != t.count { return false }
        var map = [Character:Int]()
        for c in Array(s) {
            if let _ = map[c] {
                map[c]! += 1
            } else {
                map[c] = 1
            }
        }
        for c in Array(t) {
            if let num = map[c] {
                if num == 0 {
                    return false
                }
                map[c]! -= 1
            } else {
                return false
            }
        }
        return true
    }
}
