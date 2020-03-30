import UIKit

// 105. 从前序与中序遍历序列构造二叉树
// https://leetcode-cn.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/



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
 
// 看了答案后 https://leetcode-cn.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/solution/cong-qian-xu-he-zhong-xu-bian-li-xu-lie-gou-zao-er/
class Solution {
    var preorder:[Int] = []
    var inorder:[Int] = []
    var map:[Int:Int] = [:]
    var rootIdx = 0
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        if inorder.count == 0 { return nil }
        self.preorder = preorder
        self.inorder = inorder
        for i in 0..<inorder.count {
            map[inorder[i]] = i
        }
        return helper(0, inorder.count-1)
    }
    
    func helper(_ start:Int, _ end:Int) -> TreeNode? {
        if start > end { return nil }
        let root = TreeNode(self.preorder[self.rootIdx])
        self.rootIdx += 1
        let index = self.map[root.val]!
        root.left = helper(start, index-1)
        root.right = helper(index+1, end)
        return root
    }
}
