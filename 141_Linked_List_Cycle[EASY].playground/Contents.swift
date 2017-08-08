/*
 141. Linked List Cycle
 https://leetcode.com/problems/linked-list-cycle/#/description
 
 Given a linked list, determine if it has a cycle in it.
 
 
 142. Linked List Cycle II
 https://leetcode.com/problems/linked-list-cycle-ii/#/description
 
 Given a linked list, return the node where the cycle begins. If there is no cycle, return null.
 
 Note: Do not modify the linked list.
 
 
 */

/*
 http://www.cnblogs.com/hiddenfox/p/3408931.html
 这个博客分析的非常好
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
    func hasCycle(_ l: ListNode?) -> Bool {
        var slow = l, fast = l
        while fast != nil, fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            if slow == fast {
                return true
            }
        }
        return false
    }
    
    func detectCycle(_ l: ListNode?) -> ListNode? {
        var slow = l, fast = l
        while fast != nil, fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            if slow == fast {
                var slow2 = l
                while slow2 != slow {
                    slow = slow?.next
                    slow2 = slow2?.next
                }
                return slow
            }
        }
        return nil
    }
}

