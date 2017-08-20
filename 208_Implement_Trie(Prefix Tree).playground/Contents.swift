/*
 208. Implement Trie (Prefix Tree)
 
 https://leetcode.com/problems/implement-trie-prefix-tree/description/
 
 Implement a trie with insert, search, and startsWith methods.
 
 Note:
 You may assume that all inputs are consist of lowercase letters a-z.
 */

class TrieNode {
    var val: Character
    var isWord: Bool
    var children: [TrieNode?]
    init(_ c: Character) {
        val = c
        isWord = false
        children = Array<TrieNode?>(repeating: nil, count: 26)
    }
}

func -(lhs: Character, rhs: Character) -> Int {
    return Int(String(lhs).utf16.first!) - Int(String(rhs).utf16.first!)
}

class Trie {
    private var root: TrieNode
    private let a = "a".characters.first!
    
    /** Initialize your data structure here. */
    init() {
        root = TrieNode("#".characters.first!)
    }
    
    /** Inserts a word into the trie. */
    func insert(_ word: String) {
        var current = root
        let word = Array(word.characters)
        for i in 0..<word.count {
            let c = word[i]
            if current.children[c - a] == nil {
                current.children[c - a] = TrieNode(c)
            }
            current = current.children[c - a]!
        }
        current.isWord = true
    }
    
    /** Returns if the word is in the trie. */
    func search(_ word: String) -> Bool {
        var current = root
        let word = Array(word.characters)
        for i in 0..<word.count {
            let c = word[i]
            if current.children[c - a] == nil {
                return false
            }
            current = current.children[c - a]!
        }
        return current.isWord
    }
    
    /** Returns if there is any word in the trie that starts with the given prefix. */
    func startsWith(_ prefix: String) -> Bool {
        var current = root
        let prefix = Array(prefix.characters)
        for i in 0..<prefix.count {
            let c = prefix[i]
            if current.children[c - a] == nil {
                return false
            }
            current = current.children[c - a]!
        }
        return true
    }
}


let a = "a".characters.first!
let b = "b".characters.first!
"a".unicodeScalars.first!
"a".utf16.first!
"a".utf8.first!

b - a

/**
 * Your Trie object will be instantiated and called as such:
 * Trie obj = new Trie();
 * obj.insert(word);
 * boolean param_2 = obj.search(word);
 * boolean param_3 = obj.startsWith(prefix);
 */