/*
 79. Word Search
 
 https://leetcode.com/problems/word-search/description/
 
 Given a 2D board and a word, find if the word exists in the grid.
 
 The word can be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once.
 
 For example,
 Given board =
 
 [
 ['A','B','C','E'],
 ['S','F','C','S'],
 ['A','D','E','E']
 ]
 word = "ABCCED", -> returns true,
 word = "SEE", -> returns true,
 word = "ABCB", -> returns false.
 */

class Solution {
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        guard board.count > 0, board[0].count > 0 else {
            return false
        }
        let word = Array(word.characters)
        var visited = Array<Array<Bool>>(repeating: Array<Bool>(repeating: false, count: board[0].count), count: board.count)
        for i in 0..<board.count {
            for j in 0..<board[0].count {
                if _exist(board, &visited, word, i, j, 0) {
                    return true
                }
            }
        }
        return false
    }
    
    private func _exist(_ board: [[Character]], _ visited: inout [[Bool]], _ word: [Character], _ i: Int, _ j: Int, _ index: Int) -> Bool {
        if index > word.count - 1 {
            return true
        }
        if i < 0 || i > board.count - 1 || j < 0 || j > board[0].count - 1 || visited[i][j] || board[i][j] != word[index] {
            return false
        }
        visited[i][j] = true
        if _exist(board, &visited, word, i - 1, j, index + 1) {
            return true
        }
        if _exist(board, &visited, word, i + 1, j, index + 1) {
            return true
        }
        if _exist(board, &visited, word, i, j - 1, index + 1) {
            return true
        }
        if _exist(board, &visited, word, i, j + 1, index + 1) {
            return true
        }
        visited[i][j] = false
        return false
    }
}

// 可以不用辅助数组
class Solution1 {
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        guard board.count > 0, board[0].count > 0 else {
            return false
        }
        var board = board
        let word = Array(word.characters)
        for i in 0..<board.count {
            for j in 0..<board[0].count {
                if _exist(&board, word, i, j, 0) {
                    return true
                }
            }
        }
        return false
    }
    
    private func _exist(_ board: inout [[Character]], _ word: [Character], _ i: Int, _ j: Int, _ index: Int) -> Bool {
        if index > word.count - 1 {
            return true
        }
        if i < 0 || i > board.count - 1 || j < 0 || j > board[0].count - 1 || board[i][j] == "#".characters.first! || board[i][j] != word[index] {
            return false
        }
        let char = board[i][j]
        board[i][j] = "#".characters.first!
        if _exist(&board, word, i - 1, j, index + 1) {
            return true
        }
        if _exist(&board, word, i + 1, j, index + 1) {
            return true
        }
        if _exist(&board, word, i, j - 1, index + 1) {
            return true
        }
        if _exist(&board, word, i, j + 1, index + 1) {
            return true
        }
        board[i][j] = char
        return false
    }
}

let board = [
["A".characters.first!, "B".characters.first!, "C".characters.first!, "E".characters.first!],
["S".characters.first!, "F".characters.first!, "C".characters.first!, "S".characters.first!],
["A".characters.first!, "D".characters.first!, "E".characters.first!, "E".characters.first!],
["A".characters.first!, "D".characters.first!, "E".characters.first!, "E".characters.first!],
]
Solution().exist(board, "ddd")
