/*
 215. Kth Largest Element in an Array
 
 https://leetcode.com/problems/kth-largest-element-in-an-array/description/
 
 Find the kth largest element in an unsorted array. Note that it is the kth largest element in the sorted order, not the kth distinct element.
 
 For example,
 Given [3,2,1,5,6,4] and k = 2, return 5.
 
 Note:
 You may assume k is always valid, 1 ? k ? array's length.
 */

public struct Heap<T> {
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

// O(N lg N)
class Solution {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        let nums = nums.sorted(by: >)
        return nums[k - 1]
    }
}

// O(N lg K) 
// 注意一定要保证pq的size是k，而且注意用最小堆而不是最大堆
class Solution1 {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var pq = Heap<Int>(order: <)
        
        // 这种仍然是O（nlogn）
//        for num in nums {
//            pq.insert(num)
//        }
//        for _ in 0..<k-1 {
//            pq.remove()
//        }
//        return pq.peek()!
        
        for num in nums {
            pq.insert(num)
            if pq.count > k {
                pq.remove()
            }
        }
        return pq.peek()!
    }
}

// quickselect 跟快排一样
// 注意nums要能改变，所以是inout；swap不能用系统的
class Solution2 {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var i = 0
        var j = nums.count - 1
        var nums = nums
        while true {
            let pos = partition(&nums, lo: i, hi: j)
            if pos == k-1 {
                return nums[pos]
            }
            if pos > k-1 {
                j = pos - 1
            } else {
                i = pos + 1
            }
        }
    }
    
    private func partition(_ a: inout [Int], lo: Int, hi: Int) -> Int {
        let pivot = a[lo]
        var i = lo + 1
        var j = hi
        while i <= j {
            if a[i] < pivot, a[j] > pivot {
                swap(&a, i, j)
                i += 1
                j -= 1
            }
            if a[i] >= pivot {
                i += 1
            }
            if a[j] <= pivot {
                j -= 1
            }
        }
        swap(&a, lo, j)
        return j
    }
    
    private func swap(_ a: inout [Int], _ i: Int, _ j: Int) {
        let temp = a[i]
        a[i] = a[j]
        a[j] = temp
    }
}

Solution2().findKthLargest([3,1,2,4], 2)
