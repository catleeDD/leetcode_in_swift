/*
 139. Word Break
 https://leetcode.com/problems/word-break/#/description
 
 Given a non-empty string s and a dictionary wordDict containing a list of non-empty words, determine if s can be segmented into a space-separated sequence of one or more dictionary words. You may assume the dictionary does not contain duplicate words.
 
 For example, given
 s = "leetcode",
 dict = ["leet", "code"].
 
 Return true because "leetcode" can be segmented as "leet code".
 
 */

import Foundation

// 错误答案。我已经尽力了。。。
// Solution().wordBreak("ccbb", ["bc","cb"]) 这种会错误
class Solution {
    var result = false
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        let str = Array(s.characters)
        let words = wordDict.map { Array($0.characters) }
        helper(str, words)
        return result
    }
    
    private func helper(_ s: [Character], _ wordDict: [[Character]]) {
        if s.count == 0 {
            result = true
            return
        }
        for i in 0..<wordDict.count {
            let word = wordDict[i]
            if let index = contains(s, word) {
                var tempStr = s
                tempStr.removeSubrange(index..<index+word.count)
                // 注意这里一定要从当前开始而不是从头开始
                let newWordDict = Array(wordDict[i..<wordDict.count])
                helper(tempStr, newWordDict)
            }
        }
    }
    
    func contains(_ s1: [Character], _ s2: [Character]) -> Int? {
        guard s1.count >= s2.count else {
            return nil
        }
        for i in 0..<s1.count {
            for j in 0..<s2.count {
                // 注意这里越界判断容易忘记
                if i + j > s1.count - 1 {
                    break
                }
                if s2[j] != s1[i+j] {
                    break
                }
                if j == s2.count - 1 {
                    return i
                }
            }
        }
        return nil
    }
}



Solution().wordBreak("dogs", ["dog","s","gs"])
Solution().wordBreak("ccbb", ["bc","cb"])

/*
 几个坑：
 1. arr[i..<j] 中的j是edge而不是长度！！
 2. i..<j和i...j都需要i<=j，当i=j时，前者为空，后者为一个元素
 */
// 超时
class Solution1 {
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        var str = Array(s.characters)
        let words = wordDict.map { Array($0.characters) }
        var dp = Array<Bool>(repeating: false, count: str.count + 1)
        dp[0] = true
        for i in 0..<str.count {
            for j in 0...i {
                if dp[j] && words.contains(where: { $0 == Array(str[j...i]) }) {
                    dp[i+1] = true
                    break
                }
            }
        }
        
        return dp[str.count]
    }
}

// 优化Solution1 array的contains方法效率不高
class Solution2 {
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        var dp = Array<Bool>(repeating: false, count: s.characters.count + 1)
        dp[0] = true
        for i in 0..<s.characters.count {
            for j in 0...i {
                if dp[j], wordDict.contains(s.substring(with: j..<i+1)) {
                    dp[i+1] = true
                    break
                }
            }
        }
        return dp[s.characters.count]
    }
}

extension String {
    func substring(with range: Range<Int>) -> String {
        return substring(with: index(startIndex, offsetBy: range.lowerBound)..<index(startIndex, offsetBy: range.upperBound))
    }
}

var str = "abcde"
str.substring(with: 1..<3)


var arr = [[1,2],[2],[3],[4],[5]]
arr[0...1]

Solution2().wordBreak("dogs", ["dog","s","gs"])

//Solution1().wordBreak("ccbb", ["bc","cb"])


// 看了答案后自己的答案也可以修改成正确的。关键点在于contains不能从中间开始算，而要从头开始。因为如果一开始就没有找到包含的单词，最后的结果一定为false
// 回溯法，本质上也算dfs
// 超时，主要是动态规划方法可以记录结果从而省略一些计算，这个方法会每次都计算
class Solution3 {
    var result = false
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        helper(s, wordDict)
        return result
    }
    
    private func helper(_ s: String, _ wordDict: [String]) {
        if s.characters.count == 0 {
            result = true
            return
        }
        for i in 0..<wordDict.count {
            let word = wordDict[i]
            if s == word {
                result = true
                return
            }
            if s.hasPrefix(word) {
                var temp = s
                temp = temp.substring(from: temp.index(temp.startIndex, offsetBy: word.characters.count))
                helper(temp, wordDict)
            }
        }
    }
}

// 优化3，然而还是超时
class Solution4 {
    var result = false
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        if s.characters.count == 0 {
            return true
        }
        for i in 0..<wordDict.count {
            let word = wordDict[i]
            if s == word {
                return true
            }
            if s.hasPrefix(word) {
                var temp = s
                temp = temp.substring(from: temp.index(temp.startIndex, offsetBy: word.characters.count))
                if wordBreak(temp, wordDict) {
                    return true
                }
            }
        }
        return false
    }
}


Solution4().wordBreak("dogs", ["dog","s","gs"])
Solution4().wordBreak("ccbb", ["bc","cb"])
Solution3().wordBreak("cars", ["car","ca","rs"])
Solution4().wordBreak("cars", ["car","ca","rs"])
