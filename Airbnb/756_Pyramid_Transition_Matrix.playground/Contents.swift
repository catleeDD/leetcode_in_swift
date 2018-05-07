/*
 756. Pyramid Transition Matrix
 https://leetcode.com/problems/pyramid-transition-matrix/description/
 
 We are stacking blocks to form a pyramid. Each block has a color which is a one letter string, like `'Z'`.
 
 For every block of color `C` we place not in the bottom row, we are placing it on top of a left block of color `A` and right block of color `B`. We are allowed to place the block there only if `(A, B, C)` is an allowed triple.
 
 We start with a bottom row of bottom, represented as a single string. We also start with a list of allowed triples allowed. Each allowed triple is represented as a string of length 3.
 
 Return true if we can build the pyramid all the way to the top, otherwise false.
 
 Example 1:
 Input: bottom = "XYZ", allowed = ["XYD", "YZE", "DEA", "FFF"]
 Output: true
 Explanation:
 We can stack the pyramid like this:
     A
    / \
   D   E
  / \ / \
 X   Y   Z
 
 This works because ('X', 'Y', 'D'), ('Y', 'Z', 'E'), and ('D', 'E', 'A') are allowed triples.
 Example 2:
 Input: bottom = "XXYX", allowed = ["XXX", "XXY", "XYX", "XYY", "YXZ"]
 Output: false
 Explanation:
 We can't stack the pyramid to the top.
 Note that there could be allowed triples (A, B, C) and (A, B, D) with C != D.
 Note:
 bottom will be a string with length in range [2, 8].
 allowed will have length in range [0, 200].
 Letters in all strings will be chosen from the set {'A', 'B', 'C', 'D', 'E', 'F', 'G'}.
 
 */

// dfs + backtracking
class Solution {
    func pyramidTransition(_ bottom: String, _ allowed: [String]) -> Bool {
        print()
        // 优化点：value可以用Int来存，利用bit-manipulation
        let map = allowed.reduce(into: [String:String]()) { (result, allow) in
            result[substring(allow,0,2), default:""].append(allow.last!)
        }
        print(map)
        return dfs(bottom, map: map)
    }
    
    private func dfs(_ bottom: String, map: [String:String]) -> Bool {
        if bottom.count == 1 {
            return true
        }
        for i in 0..<bottom.count - 1 {
            if !map.keys.contains(substring(bottom, i, i+2)) {
                return false
            }
        }
        var list = [String]()
        var row = ""
        genUpperRow(bottom, &row, &list, map)
        for s in list {
            if dfs(s, map: map) {
                return true
            }
        }
        return false
    }
    
    // backtracking
    private func genUpperRow(_ bottom: String, _ row: inout String, _ list: inout [String], _ map: [String: String]) {
        let i = row.count
        if i == bottom.count - 1 {
            list.append(row)
            return
        }
        for s in map[substring(bottom, i, i+2)]! {
            row.append(s)
            genUpperRow(bottom, &row, &list, map)
            row.removeLast()
        }
    }

    private func substring(_ string: String, _ from: Int, _ to: Int) -> String {
        return String(string[string.index(string.startIndex, offsetBy: from)..<string.index(string.startIndex, offsetBy: to)])
    }
}


//优化：memoization
class Solution1 {
    
    var invalid = Set<String>()
    func pyramidTransition(_ bottom: String, _ allowed: [String]) -> Bool {
        print()
        // 优化点：value可以用Int来存，利用bit-manipulation
        let map = allowed.reduce(into: [String:String]()) { (result, allow) in
            result[substring(allow,0,2), default:""].append(allow.last!)
        }
        return dfs(bottom, map: map)
    }
    
    private func dfs(_ bottom: String, map: [String:String]) -> Bool {
        if bottom.count == 1 {
            return true
        }
        if invalid.contains(bottom) {
            return false
        }
        for i in 0..<bottom.count - 1 {
            if !map.keys.contains(substring(bottom, i, i+2)) {
                invalid.insert(bottom)
                return false
            }
        }
        var list = [String]()
        var row = ""
        genUpperRows(bottom, &row, &list, map)
        for s in list {
            if dfs(s, map: map) {
                return true
            }
        }
        invalid.insert(bottom)
        return false
    }
    
    // backtracking 其实就是全排列permutation
    private func genUpperRows(_ bottom: String, _ row: inout String, _ list: inout [String], _ map: [String: String]) {
        let i = row.count
        if i == bottom.count - 1 {
            list.append(row)
            return
        }
        for s in map[substring(bottom, i, i+2)]! {
            row.append(s)
            genUpperRows(bottom, &row, &list, map)
            row.removeLast()
        }
    }
    
    private func substring(_ string: String, _ from: Int, _ to: Int) -> String {
        return String(string[string.index(string.startIndex, offsetBy: from)..<string.index(string.startIndex, offsetBy: to)])
    }
}



// dp
Solution().pyramidTransition("XYZ", ["XYD", "YZE", "DEA", "FFF", "YZA"])
Solution1().pyramidTransition("XYZ", ["XYD", "YZE", "DEA", "FFF", "YZA"])
