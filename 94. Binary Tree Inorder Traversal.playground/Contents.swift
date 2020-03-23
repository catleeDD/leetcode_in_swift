import UIKit

// 94. Binary Tree Inorder Traversal
// https://leetcode-cn.com/problems/binary-tree-inorder-traversal/



  public class TreeNode {
      public var val: Int
      public var left: TreeNode?
      public var right: TreeNode?
      public init(_ val: Int) {
          self.val = val
          self.left = nil
          self.right = nil
      }
  }



class Solution {
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        guard root != nil else {return []}
        var stack:[TreeNode] = []
        var ret = [Int]()
        var cur = root
        while !stack.isEmpty || cur != nil {
            while cur != nil {
                stack.append(cur!)
                cur = cur!.left
            }
            cur = stack.popLast()
            ret.append(cur!.val)
            cur = cur?.right
        }
        return ret
    }
}
