/*
 3. Longest Substring Without Repeating Characters
 
 https://leetcode.com/problems/longest-substring-without-repeating-characters/#/description
 
 Given a string, find the length of the longest substring without repeating characters.
 
 Examples:
 
 Given "abcabcbb", the answer is "abc", which the length is 3.
 
 Given "bbbbb", the answer is "b", with the length of 1.
 
 Given "pwwkew", the answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
*/


//O(n^2)
class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var maxCount = 0
        let chars = Array(s.characters)
        for i in 0..<chars.count {
            var set = Set<Character>()
            for j in i..<chars.count {
                if set.contains(chars[j]) {
                    maxCount = max(maxCount, set.count)
                    break
                } else {
                    set.insert(chars[j])
                }
            }
            maxCount = max(maxCount, set.count)
        }
        
        return maxCount
    }
}

//O(n) set
class Solution1 {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var maxCount = 0
        let chars = Array(s.characters)
        var i = 0, j = 0
        var set = Set<Character>()
        while j < chars.count {
            if !set.contains(chars[j]) {
                set.insert(chars[j])
                j += 1
                maxCount = max(maxCount, set.count)
            } else {
                set.remove(chars[i])
                i += 1
            }
        }
        
        return maxCount
    }
}

//O(n) 跟 1 一样，但更好理解一点
class Solution2 {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var maxCount = 0
        let chars = Array(s.characters)
        var i = 0
        var set = Set<Character>()
        for j in 0..<chars.count {
            if !set.contains(chars[j]) {
                set.insert(chars[j])
                maxCount = max(maxCount, set.count)
            } else {
                while set.contains(chars[j]) {
                    set.remove(chars[i])
                    i += 1
                }
            }
        }
        
        return maxCount
    }
}

//O(n) map
class Solution3 {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var maxCount = 0
        let chars = Array(s.characters)
        var i = 0
        var map = [Character: Int]()
        for j in 0..<chars.count {
            if map.keys.contains(chars[j]) {
                i = max(i, map[chars[j]]! + 1)
            }
            map[chars[j]] = j
            maxCount = max(maxCount, j - i + 1)
        }
        
        return maxCount
    }
}


Solution3().lengthOfLongestSubstring("jbpnbwwd")
