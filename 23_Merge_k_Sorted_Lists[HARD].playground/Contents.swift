/*
 23. Merge k Sorted Lists
 
 https://leetcode.com/problems/merge-k-sorted-lists/description/
 
 Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }

}

// divide and conquer
// 还可以直接一个一个merge，一个循环就够了
class Solution {
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        if lists.count == 0 {
            return nil
        }
        if lists.count == 1 {
            return lists[0]
        }
        let mid = lists.count / 2
        let list1 = mergeKLists(Array(lists[0..<mid]))
        let list2 = mergeKLists(Array(lists[mid..<lists.count]))
        return mergeTwoLists(list1, list2)
    }
    
    private func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let dummy = ListNode(0)
        var head = dummy
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
        return dummy.next
    }
}

// heap
class Solution1 {
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        if lists.count == 0 {
            return nil
        }
        if lists.count == 1 {
            return lists[0]
        }
        let dummy: ListNode? = ListNode(0)
        var tail = dummy
        var pq = Heap<ListNode> {$0.val < $1.val}
        lists.flatMap {$0}.forEach {pq.insert($0)}
        while !pq.isEmpty {
            tail?.next = pq.remove()
            tail = tail?.next
            if let node = tail?.next {
                pq.insert(node)
            }
        }
        
        return dummy?.next
    }
    
    private struct Heap<T> {
        var elements = [T]()
        
        fileprivate var order: (T, T) -> Bool
        
        public init(order: @escaping (T, T) -> Bool) {
            self.order = order
        }
        
        public init(array: [T], order: @escaping (T, T) -> Bool) {
            self.order = order
            buildHeap(fromArray: array)
        }
        
        public var isEmpty: Bool {
            return elements.isEmpty
        }
        
        public var count: Int {
            return elements.count
        }
        
        public func peek() -> T? {
            return elements.first
        }
        
        /**
         * Adds a new value to the heap. This reorders the heap so that the max-heap
         * or min-heap property still holds. Performance: O(log n).
         */
        public mutating func insert(_ value: T) {
            elements.append(value)
            swim(elements.count - 1)
        }
        
        /**
         * Removes the root node from the heap. For a max-heap, this is the maximum
         * value; for a min-heap it is the minimum value. Performance: O(log n).
         */
        @discardableResult
        public mutating func remove() -> T? {
            if elements.isEmpty {
                return nil
            } else if elements.count == 1 {
                return elements.removeLast()
            } else {
                let value = elements[0]
                elements[0] = elements.removeLast()
                sink(0)
                return value
            }
        }
        
        mutating func swim(_ index: Int) {
            var childIndex = index
            while childIndex > 0 && order(elements[childIndex], elements[(childIndex - 1) / 2]) {
                swap(&elements[childIndex], &elements[(childIndex - 1) / 2])
                childIndex = (childIndex - 1) / 2
            }
        }
        
        mutating func sink(_ index: Int) {
            var parentIndex = index
            while 2*parentIndex + 2 <= elements.count {
                let leftChildIndex = 2*parentIndex + 1
                let rightChildIndex = 2*parentIndex + 2
                
                var next = parentIndex
                if leftChildIndex < elements.count && order(elements[leftChildIndex], elements[next]) {
                    next = leftChildIndex
                }
                if rightChildIndex < elements.count && order(elements[rightChildIndex], elements[next]) {
                    next = rightChildIndex
                }
                if next == parentIndex { break }
                
                swap(&elements[parentIndex], &elements[next])
                parentIndex = next
            }
        }
        
        // This version has O(n log n) performance.
        private mutating func buildHeap(array: [T]) {
            for value in array {
                insert(value)
            }
        }
        
        // This runs pretty much in O(n).
        private mutating func buildHeap(fromArray array: [T]) {
            elements = array
            for i in (0...elements.count / 2 - 1).reversed() {
                sink(i)
            }
        }
    }

}
