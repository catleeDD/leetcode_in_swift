//: Playground - noun: a place where people can play

import UIKit

/*

 331. Verify Preorder Serialization of a Binary Tree
 https://leetcode.com/problems/verify-preorder-serialization-of-a-binary-tree/#/description

 One way to serialize a binary tree is to use pre-order traversal. When we encounter a non-null node, we record the node's value. If it is a null node, we record using a sentinel value such as #.
 
      _9_
     /   \
    3     2
   / \   / \
  4   1  #  6
 / \ / \   / \
 # # # #   # #
 For example, the above binary tree can be serialized to the string "9,3,4,#,#,1,#,#,2,#,6,#,#", where # represents a null node.
 
 Given a string of comma separated values, verify whether it is a correct preorder traversal serialization of a binary tree. Find an algorithm without reconstructing the tree.
 
 Each comma separated value in the string must be either an integer or a character '#' representing null pointer.
 
 You may assume that the input format is always valid, for example it could never contain two consecutive commas such as "1,,3".
 
 Example 1:
 "9,3,4,#,#,1,#,#,2,#,6,#,#"
 Return true
 
 Example 2:
 "1,#"
 Return false
 
 Example 3:
 "9,#,#,1"
 Return false
 

*/

// stack
class Solution {
    func isValidSerialization(_ preorder: String) -> Bool {
        let comp = preorder.components(separatedBy: ",")
        var stack = [String]()
        for value in comp {
            stack.append(value)
            while stack.count >= 3, stack[stack.count - 1] == "#", stack[stack.count - 2] == "#", stack[stack.count - 3] != "#" {
                stack.removeLast()
                stack.removeLast()
                stack[stack.count - 1] = "#"
            }
        }

        return stack.count == 1 && stack.first == "#"
    }
}


// 递归
class Solution1 {
    func isValidSerialization(_ preorder: String) -> Bool {
        let prefix = preorder.components(separatedBy: ",").map { $0 == "#" ? $0 : "x" }.joined()
        return convert(prefix) == "#"
    }
    
    func convert(_ string: String) -> String {
        let result = string.replacingOccurrences(of: "x##", with: "#")
        if string.characters.count == result.characters.count {
            return result
        } else {
            return convert(result)
        }
    }
}

/*
 出度 入度 思想很好
 In a binary tree, if we consider null as leaves, then
 all non-null node provides 2 outdegree and 1 indegree (2 children and 1 parent), except root
 all null node provides 0 outdegree and 1 indegree (0 child and 1 parent).
 Suppose we try to build this tree. During building, we record the difference between out degree and in degree diff = outdegree - indegree. When the next node comes, we then decrease diff by 1, because the node provides an in degree. If the node is not null, we increase diff by2, because it provides two out degrees. If a serialization is correct, diff should never be negative and diff will be zero when finished.
 
 */
class Solution2 {
    func isValidSerialization(_ preorder: String) -> Bool {
        let nodes = preorder.components(separatedBy: ",")
        var diff = 1
        for node in nodes {
            diff -= 1
            if diff < 0 { return false }
            if node != "#" {
                diff += 2
            }
        }
        return diff == 0
    }
}

Solution2().isValidSerialization( "9,#,#,1")

