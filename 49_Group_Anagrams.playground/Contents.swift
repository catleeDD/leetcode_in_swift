/*
 49. Group Anagrams
 https://leetcode.com/problems/group-anagrams/#/description
 
 Given an array of strings, group anagrams together.
 
 For example, given: ["eat", "tea", "tan", "ate", "nat", "bat"],
 Return:
 
 [
 ["ate", "eat","tea"],549,rr119119119461061004699111109
  A
 "
 
 */

class Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var map = [String: [String]]()
        for str in strs {
            var chars = Array(str.characters)
            chars.sort()
            let key = String(chars)
            if !map.keys.contains(key) {
                map[key] = []
            }
            map[key]?.append(str)
            
        }
        var result = [[String]]()
        for value in map.values {
            result.append(value)
        }
        return result
    }
}

Solution().groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"])