/*
 108. Convert Sorted Array to Binary Search Tree
 https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree/#/description
 
 Given an array where elements are sorted in ascending order, convert it to a height balanced BST.
 */

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
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        if nums.count == 0 {
            return nil
        }
        if nums.count == 1 {
            return TreeNode(nums[0])
        }
        var i = (nums.count - 1) / 2
        let root = TreeNode(nums[i])
        root.left = sortedArrayToBST(Array(nums[0..<i]))
        root.right = sortedArrayToBST(Array(nums[i+1..<nums.count]))
        
        return root
    }
}

// 非递归
class Solution1 {
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        if nums.count == 0 {
            return nil
        }
        var i = (nums.count - 1) / 2
        let root = TreeNode(nums[i])
        var stack = [(TreeNode, Int, Int)]()
        stack.append((root, 0, nums.count - 1))
        while let (node, l, r) = stack.popLast() {
            let mid = l+(r-l)/2
            if r > mid {
                node.right = TreeNode(nums[mid+1+(r-mid-1)/2])
                stack.append((node.right!, mid+1, r))
            }
            if l < mid {
                node.left = TreeNode(nums[l+(mid-1-l)/2])
                stack.append((node.left!, l, mid-1))
            }
        }
        
        return root
    }
}