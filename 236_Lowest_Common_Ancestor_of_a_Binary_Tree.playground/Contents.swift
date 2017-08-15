/*
 236. Lowest Common Ancestor of a Binary Tree
 https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/description/
 
 Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.
 
 According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes v and w as the lowest node in T that has both v and w as descendants (where we allow a node to be a descendant of itself).”
 
 _______3______
 /              \
 ___5__          ___1__
 /      \        /      \
 6      _2       0       8
 /  \
 7   4
 For example, the lowest common ancestor (LCA) of nodes 5 and 1 is 3. Another example is LCA of nodes 5 and 4 is 5, since a node can be a descendant of itself according to the LCA definition.
 */

public class TreeNode: AnyObject {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

// 一种简单的方法是DFS分别寻找到两个节点p和q的路径，然后对比路径，查看他们的第一个分岔口，则为LCA。
class Solution {
    func lowestCommonAncestor(_ root: TreeNode, _ p: TreeNode, _ q: TreeNode) -> TreeNode {
        var parents = [ObjectIdentifier: TreeNode?]()
        var stack = [TreeNode]()
        parents[ObjectIdentifier(root)] = nil
        stack.append(root)
        // 找到路径
        var node: TreeNode
        while !parents.keys.contains(ObjectIdentifier(p)) || !parents.keys.contains(ObjectIdentifier(q)) {
            node = stack.popLast()!
            if let left = node.left {
                parents[ObjectIdentifier(left)] = node
                stack.append(left)
            }
            if let right = node.right {
                parents[ObjectIdentifier(right)] = node
                stack.append(right)
            }
        }
        // 沿着p->root的路径找到p的所有parent
        var ancestors = Set<ObjectIdentifier>()
        var parent: TreeNode? = p
        while parent != nil {
            ancestors.insert(ObjectIdentifier(parent!))
            parent = parents[ObjectIdentifier(parent!)]!
        }
        // 沿着q->root的路径找，直到q的parent在ancestors中，此时最后一个parent就是LCA
        var result: TreeNode! = q
        while !ancestors.contains(ObjectIdentifier(q)) {
            result = parents[ObjectIdentifier(q)]!
        }
        return result!
    }
}


// https://segmentfault.com/a/1190000003509399
// https://www.hrwhisper.me/algorithm-lowest-common-ancestor-of-a-binary-tree/

// Using a bottom-up approach, we can improve over the top-down approach by avoiding traversing the same nodes over and over again.
// We traverse from the bottom, and once we reach a node which matches one of the two nodes, we pass it up to its parent. The parent would then test its left and right subtree if each contain one of the two nodes. If yes, then the parent must be the LCA and we pass its parent up to the root. If not, we pass the lower node which contains either one of the two nodes (if the left or right subtree contains either p or q), or NULL (if both the left and right subtree does not contain either p or q) up.
// 思路就是用后序遍历，lowestCommonAncestor不仅代表找到了公共祖先也代表这个分支找到了这个node
class Solution1 {
    func lowestCommonAncestor(_ root: TreeNode, _ p: TreeNode, _ q: TreeNode) -> TreeNode {
        return _lowestCommonAncestor(root, p, q)!
    }
    
    private func _lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode, _ q: TreeNode) -> TreeNode? {
        guard let root = root else { return nil }
        if root === p {
            return p
        }
        if root === q {
            return q
        }
        let left = _lowestCommonAncestor(root.left, p, q)
        let right = _lowestCommonAncestor(root.right, p, q)
        if left != nil, right != nil {
            return root
        }
        if left != nil {
            return left
        }
        return right
    }
}
