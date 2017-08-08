/*
 234. Palindrome Linked List
 https://leetcode.com/problems/palindrome-linked-list/#/description
 
 Given a singly linked list, determine if it is a palindrome.
 
 Follow up:
 Could you do it in O(n) time and O(1) space?
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
    func isPalindrome(_ head: ListNode?) -> Bool {
        var fast = head
        var slow = head
        while fast != nil, fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        // odd
        if fast != nil {
            slow = slow?.next
        }
        
        var right = reverseList(slow)
        var left = head
        while right != nil {
            if left?.val != right?.val {
                return false
            }
            left = left?.next
            right = right?.next
        }
        return true
    }
    
    private func reverseList(_ head: ListNode?) -> ListNode? {
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