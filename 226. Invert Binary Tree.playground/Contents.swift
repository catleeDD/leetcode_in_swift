import UIKit

// 226. Invert Binary Tree
// https://leetcode-cn.com/problems/invert-binary-tree/



 
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
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard root != nil else {
            return nil
        }
        let temp = root?.left
        root?.left = root?.right
        root?.right = temp
        invertTree(root?.left)
        invertTree(root?.right)
        return root
    }
}

// 遍历，类似BFS
class Solution {
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard root != nil else {
            return nil
        }
        var queue = [root!]
        while !queue.isEmpty {
            let node = queue.removeFirst()
            let temp = node.left
            node.left = node.right
            node.right = temp
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
        return root
    }
}
