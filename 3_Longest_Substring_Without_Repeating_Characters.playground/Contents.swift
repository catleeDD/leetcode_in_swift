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

// 以下三种方法是substring的标准方法：sliding window + two points
// 只是用来表示sliding window的方式有set，map和字母array三种。具体可以看leetcode的Solution

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
                maxCount = max(maxCount, j - i + 1)
                j += 1
            } else {
                set.remove(chars[i])
                i += 1
            }
        }
        
        return maxCount
    }
}

//O(n) map
// map和下面的array比set的优点是可以记录索引，所以i可以直接跳到对应的索引而不用一个一个往右走。
// 所以上面的算法复杂度是2n，下面两个是n
class Solution2 {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var maxCount = 0
        let chars = Array(s.characters)
        var i = 0, j = 0
        var map = [Character: Int]()
        while j < chars.count {
            if map.keys.contains(chars[j]) {
                i = max(i, map[chars[j]]! + 1)
            }
            map[chars[j]] = j
            maxCount = max(maxCount, j - i + 1)
            j += 1
        }
        
        return maxCount
    }
}

//O(n) 字母表array
//int[26] for Letters 'a' - 'z' or 'A' - 'Z'
//int[128] for ASCII
//int[256] for Extended ASCII
class Solution3 {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var maxCount = 0
        let chars = Array(s.characters)
        var i = 0, j = 0
        var index = Array<Int>(repeating: -1, count: 128)
        while j < chars.count {
            if index[chars[j].toInt()] >= 0 {
                i = max(i, index[chars[j].toInt()] + 1)
            }
            index[chars[j].toInt()] = j
            maxCount = max(maxCount, j - i + 1)
            j += 1
        }
        
        return maxCount
    }
}

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

Solution3().lengthOfLongestSubstring("jbpnbwwd")
