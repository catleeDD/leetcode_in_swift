import UIKit

// 28. Implement strStr()
// https://leetcode-cn.com/problems/implement-strstr/

// 复杂度 O(NL)
class Solution {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        if needle.count == 0 {
            return 0
        }
        let haystack = Array(haystack), needle = Array(needle)
        var i = 0, j = 0
        while i < haystack.count {// 这里可以优化：i<haystack.count-needle.count+1，因为再往后就不可能了
            while j < needle.count && i < haystack.count { // 这里得加上i < haystack.count，防止haystack越界
                if haystack[i] == needle[j] {
                    if j == needle.count-1 {
                        return i-j
                    }
                    i+=1
                    j+=1
                } else {
                    i=i-j+1
                    j=0
                    break
                }
            }
        }
        return -1
    }
}

// 注明的KMP算法，复杂度O（MN）
// https://leetcode-cn.com/problems/implement-strstr/solution/kmp-suan-fa-xiang-jie-by-labuladong/

Solution().strStr("", "elloi")

// "hello" "ll" => 2
// "aaaaa" "bba" => -1
// "aaa" "" => 0
