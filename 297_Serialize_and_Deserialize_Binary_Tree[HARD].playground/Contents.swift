/*
 https://leetcode.com/problems/serialize-and-deserialize-binary-tree/description/
 Serialization is the process of converting a data structure or object into a sequence of bits so that it can be stored in a file or memory buffer, or transmitted across a network connection link to be reconstructed later in the same or another computer environment.
 
 Design an algorithm to serialize and deserialize a binary tree. There is no restriction on how your serialization/deserialization algorithm should work. You just need to ensure that a binary tree can be serialized to a string and this string can be deserialized to the original tree structure.
 
 For example, you may serialize the following tree
 
     1
    / \
   2   3
  / \
 4   5
 as "[1,2,3,null,null,4,5]", just the same as how LeetCode OJ serializes a binary tree. You do not necessarily need to follow this format, so please be creative and come up with different approaches yourself.
 Note: Do not use class member/global/static variables to store states. Your serialize and deserialize algorithms should be stateless.
 */

class TreeNode {
    let val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ x: Int) { val = x }
}

// 递归 preorder dfs
class Codec {
    
    let X = "X".characters.first!
    let spliter = ",".characters.first!
    
    // Encodes a tree to a single string.
    func serialize(_ root: TreeNode?) -> String {
        var temp = [Character]()
        buildString(root, &temp)
        return String(temp)
    }
    
    private func buildString(_ node: TreeNode?, _ temp: inout [Character]) {
        if let node = node {
            temp.append(String(node.val).characters.first!)
            temp.append(spliter)
            buildString(node.left, &temp)
            buildString(node.right, &temp)
        } else {
            temp.append(X)
            temp.append(spliter)
        }
    }
    
    // Decodes your encoded data to tree.
    func deserialize(_ data: String) -> TreeNode? {
        var nodes = data.characters.split(separator: spliter).map(String.init)
        return buildTree(&nodes)
    }
    
    private func buildTree(_ temp: inout [String]) -> TreeNode? {
        if temp.count == 0 {
            return nil
        }
        let char = temp.removeFirst()
        if char.characters.first! == X {
            return nil
        } else {
            let node = TreeNode(Int(char)!)
            node.left = buildTree(&temp)// 此时会递归地把左子树都remove完，就剩下右子树了
            node.right = buildTree(&temp)
            return node
        }
    }
}

// 非递归 BFS
public class Codec1 {
    let X = "X".characters.first!
    let spliter = ",".characters.first!
    
    func serialize(_ root: TreeNode?) -> String {
        guard let root = root else { return "" }
        var q = [TreeNode?]()
        var res = [Character]()
        q.append(root)
        while !q.isEmpty {
            if let node = q.removeFirst() {
                res.append(String(node.val).characters.first!)
                res.append(spliter)
                q.append(node.left)
                q.append(node.right)
            } else {
                res.append(X)
                res.append(spliter)
            }
        }
        return String(res)
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        if data == "" { return nil }
        var q = [TreeNode]()
        var nodes = data.characters.split(separator: spliter).map(String.init)
        let root = TreeNode(Int(nodes[0])!)
        q.append(root)
        var i = 1
        while i < nodes.count {
            let parent = q.removeFirst()
            if nodes[i] != String(X) {
                let left = TreeNode(Int(nodes[i])!)
                parent.left = left
                q.append(left)
            }
            i += 1
            if nodes[i] != String(X) {
                let right = TreeNode(Int(nodes[i])!)
                parent.right = right
                q.append(right)
            }
            i += 1
        }
        return root
    }
}

// Your Codec object will be instantiated and called as such:
let codec = Codec1()
let tree = codec.deserialize("1,2,4,X,X,5,X,X,3,X,X")
let string = codec.serialize(tree)

let tree1 = codec.deserialize("1,X,X")
let string1 = codec.serialize(tree1)

let string2 = codec.serialize(nil)
let tree2 = codec.deserialize(string2)
