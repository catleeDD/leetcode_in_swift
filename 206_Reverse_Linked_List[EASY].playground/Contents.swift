/*
 206. Reverse Linked List
 https://leetcode.com/problems/reverse-linked-list/#/description
 
 Reverse a singly linked list.
 
 Hint:
 A linked list can be reversed either iteratively or recursively. Could you implement both?
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    func reverseList(_ head: ListNode?) -> ListNode? {
        var newHead: ListNode? = nil
        var head = head
        while head != nil {
            let temp = head?.next
            head?.next = newHead
            newHead = head
            head = temp
        }
        return newHead
    }
}

class Solution1 {
    func reverseList(_ head: ListNode?) -> ListNode? {
        return reverseList(head, nil)
    }
    
    private func reverseList(_ head: ListNode?, _ newHead: ListNode?) -> ListNode? {
        if head == nil {
            return newHead
        }
        let temp = head?.next
        head?.next = newHead
        return reverseList(temp, head)
    }
}