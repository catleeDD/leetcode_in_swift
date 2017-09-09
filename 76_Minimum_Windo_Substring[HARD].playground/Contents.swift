/*
 76. Minimum Window Substring
 https://leetcode.com/problems/minimum-window-substring/description/
 
 Given a string S and a string T, find the minimum window in S which will contain all the characters in T in complexity O(n).
 
 For example,
 S = "ADOBECODEBANC"
 T = "ABC"
 Minimum window is "BANC".
 
 Note:
 If there is no such window in S that covers all characters in T, return the empty string "".
 
 If there are multiple such windows, you are guaranteed that there will always be only one unique minimum window in S.
 */

// 有模板方法，参考LeetCode第一个discuss。其实不用套，只需要知道substring类题目的通用标准方法：sliding window + two points + map(or 字母array)

extension Character
{
    func toInt() -> Int
    {
        var intFromCharacter:Int = 0
        for scalar in String(self).unicodeScalars
        {
            intFromCharacter = Int(scalar.value)
        }
        return intFromCharacter
    }
}

class Solution {
    func minWindow(_ s: String, _ t: String) -> String {
        var minCount = Int.max, head = 0
        let s = Array(s.characters)
        let t = Array(t.characters)
        var i = 0, j = 0, count = t.count
        var counts = Array<Int>(repeating: 0, count: 128)
        t.forEach { (c) in
            counts[c.toInt()] += 1
        }
        while j < s.count {
            if counts[s[j].toInt()] > 0 {
                count -= 1
            }
            counts[s[j].toInt()] -= 1
            j += 1
            while count == 0 { //find valid substring
                // minimum the substring by move i forward
                if j - i < minCount {
                    minCount = j - i
                    head = i
                }
                if counts[s[i].toInt()] == 0 {
                    count += 1
                }
                counts[s[i].toInt()] += 1
                i += 1
            }
        }
        return minCount == Int.max ? "" : String(s[head..<(head+minCount)])
    }
}

Solution().minWindow("ADOBECODEBANC", "ABC")

