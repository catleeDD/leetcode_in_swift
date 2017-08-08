/*
 148. Sort List
 https://leetcode.com/problems/sort-list/#/description
 
 Sort a linked list in O(n log n) time using constant space complexity.
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
    func sortList(_ head: ListNode?) -> ListNode? {
        if head == nil {
            return nil
        }
        if head?.next == nil {
            return head
        }
        var prev = head, slow = head, fast = head
        while fast != nil, fast?.next != nil {
            prev = slow
            slow = slow?.next
            fast = fast?.next?.next
        }
        prev?.next = nil
        
        let firstHalf = sortList(head)
        let secondHalf = sortList(slow)
        return mergeTwoLists(firstHalf, secondHalf)
    }
    
    private func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let result = ListNode(0)
        var head = result
        var l1 = l1
        var l2 = l2
        while l1 != nil, l2 != nil {
            if l1!.val < l2!.val {
                head.next = l1
                l1 = l1?.next
            } else {
                head.next = l2
                l2 = l2?.next
            }
            head = head.next!
        }
        head.next = l1 != nil ? l1 : l2
        return result.next
    }
}

// 还有一种自底向上的算法，不用递归，可以达到真正的O（1）空间复杂度，有点复杂，就不写了
