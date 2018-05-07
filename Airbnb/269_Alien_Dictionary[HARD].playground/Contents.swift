/*
 269. Alien Dictionary
 
 https://leetcode.com/problems/alien-dictionary/description/
 
 There is a new alien language which uses the latin alphabet. However, the order among letters are unknown to you. You receive a list of non-empty words from the dictionary, where words are sorted lexicographically by the rules of this new language. Derive the order of letters in this language.
 
 Example 1:
 Given the following words in dictionary,
 
 [
 "wrt",
 "wrf",
 "er",
 "ett",
 "rftt"
 ]
 The correct order is: "wertf".
 
 Example 2:
 Given the following words in dictionary,
 
 [
 "z",
 "x"
 ]
 The correct order is: "zx".
 
 Example 3:
 Given the following words in dictionary,
 
 [
 "z",
 "x",
 "z"
 ]
 The order is invalid, so return "".
 
 Note:
 You may assume all letters are in lowercase.
 You may assume that if a is a prefix of b, then a must appear before b in the given dictionary.
 If the order is invalid, return an empty string.
 There may be multiple valid order of letters, return any one of them is fine.
 */

// 图的表示方式有三种：邻接矩阵，邻接表，边的数组。一般用后两种
// 这道题用邻接表+拓扑排序
class Solution {
    func alienOrder(_ words: [String]) -> String {
        var graph = [Character: Set<Character>]()
        var indegree = [Character: Int]()
        let words = words.map { Array($0) }
        for word in words {
            for c in word {
                indegree[c] = 0
            }
        }
        
        for i in 1..<words.count {
            let word1 = words[i-1], word2 = words[i]
            let minLen = min(word1.count, word2.count)
            for k in 0..<minLen {
                if word1[k] != word2[k] {
//                    graph[word1[k], default:Set<Character>()].insert(word2[k])
//                    indegree[word2[k]]! += 1
                    // 以上写法是错误的，会造成indegree多算
                    var set = graph[word1[k], default:Set<Character>()]
                    if !set.contains(word2[k]) {
                        set.insert(word2[k])
                        graph[word1[k]] = set
                        indegree[word2[k]]! += 1
                    }
                    break
                }
            }
        }
        
        var queue = [Character]()
        var result = [Character]()
        for (c, v) in indegree {
            if v == 0 {
                queue.append(c)
            }
        }
        while !queue.isEmpty {
            let c = queue.removeFirst()
            result.append(c)
            if let set = graph[c] {
                for c1 in set {
                    indegree[c1]! -= 1
                    if indegree[c1]! == 0 {
                        queue.append(c1)
                    }
                }
            }
        }
        
        if result.count < indegree.count {
            return ""
        }
        
        return String(result)
    }
}

//Solution().alienOrder( [
//    "wrt",
//    "wrf",
//    "er",
//    "ett",
//    "rftt"
//    ])
//Solution().alienOrder( [
//    "z",
//    "x",
//    "z",
//    ])

Solution().alienOrder(["za","zb","ca","cb"])
