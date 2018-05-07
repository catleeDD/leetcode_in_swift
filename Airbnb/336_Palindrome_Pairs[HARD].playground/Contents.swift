/*
 336. Palindrome Pairs
 https://leetcode.com/problems/palindrome-pairs/description/
 Given a list of unique words, find all pairs of distinct indices (i, j) in the given list, so that the concatenation of the two words, i.e. words[i] + words[j] is a palindrome.
 
 Example 1:
 Given words = ["bat", "tab", "cat"]
 Return [[0, 1], [1, 0]]
 The palindromes are ["battab", "tabbat"]
 Example 2:
 Given words = ["abcd", "dcba", "lls", "s", "sssll"]
 Return [[0, 1], [1, 0], [3, 2], [2, 4]]
 The palindromes are ["dcbaabcd", "abcddcba", "slls", "llssssll"]
 */

// Time Limit Exceeded。应该是n^3
class Solution {
    func palindromePairs(_ words: [String]) -> [[Int]] {
        var result = [[Int]]()
        if words.count <= 1 {
            return result
        }
        for i in 0..<words.count {
            for j in 0..<words.count {
                if j == i {
                    continue
                }
                if isPalindrome(words[i] + words[j]) {
                    result.append([i,j])
                }
            }
        }
        return result
    }

    private func isPalindrome(_ a: String) -> Bool {
        var i = 0, j = a.count-1
        let a = Array(a)
        while i <= j {
            if a[i] != a[j] {
                return false
            }
            i += 1
            j -= 1
        }
        return true
    }
}

// 思路是回文的特性，可还是TLE
class Solution1 {
    func palindromePairs(_ words: [String]) -> [[Int]] {
        var result = [[Int]]()
        if words.count <= 1 {
            return result
        }
        var map = [String:Int]()
        for i in 0..<words.count {
            map[words[i]] = i
        }
//        print(map)
        for i in 0..<words.count {
            // 这里+1是为了防止出现空字符串
            for j in 0..<words[i].count+1 {
                let l = words[i].substring(0, j)
//                print("l:"+l)
                let r = words[i].substring(j)
//                print("r:"+r)
                if isPalindrome(l), let index = map[String(r.reversed())], index != i {
                    result.append([index, i])
                }
                // r.count > 0 防止重复，["ab","ba"]的情况
                if r.count > 0, isPalindrome(r), let index = map[String(l.reversed())], index != i {
                    result.append([i, index])
                }
            }
        }
        return result
    }
    
    private func isPalindrome(_ a: String) -> Bool {
        var i = 0, j = a.count-1
        let a = Array(a)
        while i <= j {
            if a[i] != a[j] {
                return false
            }
            i += 1
            j -= 1
        }
        return true
    }
}

Solution().palindromePairs(["ab","ba"])
Solution1().palindromePairs(["ab","ba"])

// Trie
// 一开始Array和String频繁转换，结果是（129 / 134 test cases passed. ），后来改成一开始就变成Array就勉强通AC了
// https://leetcode.com/problems/palindrome-pairs/discuss/79195/O(n*k2)-java-solution-with-Trie-structure

// 模仿java
extension String {
    func substring(_ l: Int, _ r: Int) -> String {
        let start = self.startIndex
        return String(self[self.index(start, offsetBy: l)..<self.index(start, offsetBy: r)])
    }
    
    func substring(_ l: Int) -> String {
        let start = self.startIndex
        return String(self[self.index(start, offsetBy: l)...])
    }
}

func -(lhs: Character, rhs: Character) -> Int {
    return Int(lhs.unicodeScalars.first!.value) - Int(rhs.unicodeScalars.first!.value)
}

class TrieNode {
    var next = Array<TrieNode?>(repeating: nil, count: 26)
    var index = -1 //当前word在words中的index，正数表示是一个单词（且位置为index），不是单词则为-1
    var palindromeList = [Int]() // 表示满足“从0到当前char所组成的单词是palindrome且suffix为当前word”这个条件的word
}

class Solution2 {
    func palindromePairs(_ words: [String]) -> [[Int]] {
        var result = [[Int]]()
        let root = TrieNode()
        // 这个如果不这么改就会TLE
        let words = words.map { Array($0) }
        for i in 0..<words.count {
            addWord(root, words[i], i)
        }
        for i in 0..<words.count {
            search(root, words[i], i, &result)
        }
        return result
    }
    
    private func addWord(_ root: TrieNode, _ word: [Character], _ index: Int) {
        var node = root
        for i in (0..<word.count).reversed() {
            let j = word[i] - "a".first!
            if node.next[j] == nil {
                node.next[j] = TrieNode()
            }
            if isPalindrome(word, 0, i) {
                // 当前word满足条件，存入palindromeList中
                node.palindromeList.append(index)
            }
            node = node.next[j]!
        }
        // last char
        node.palindromeList.append(index)
        node.index = index
    }
    
    private func search(_ root: TrieNode, _ word: [Character], _ index: Int, _ result: inout [[Int]]) {
        var node = root
        for j in 0..<word.count {
            // word比较长
            if node.index >= 0 && node.index != index && isPalindrome(word, j, word.count - 1) {
                result.append([index, node.index])
            }
            if let n = node.next[word[j] - "a".first!] {
                node = n
            } else {
                return
            }
        }
        // trie比较长
        for j in node.palindromeList {
            if j != index {
                result.append([index, j])
            }
        }
    }
    
    private func isPalindrome(_ a: [Character], _ i: Int, _ j: Int) -> Bool {
        var i = i, j = j
        while i < j {
            if a[i] != a[j] {
                return false
            }
            i += 1
            j -= 1
        }
        return true
    }
}

Solution1().palindromePairs(["ab","ba"])
Solution2().palindromePairs(["ab","ba"])
Solution1().palindromePairs(["a","b","c","ab","ac","aa"])
Solution2().palindromePairs(["a","b","c","ab","ac","aa"])
