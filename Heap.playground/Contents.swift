
/*
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Heap
 
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
        while 2*parentIndex + 2 < elements.count {
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

class HeapSort {
    func sort(_ array: inout [Int]) {
        var heap = Heap<Int>(array: array, order: >)
        for i in 0..<array.count {
            array[i] = heap.remove()!
        }
    }
    
    // 只用sink
    func sortInPlace(_ array: inout [Int]) {
        for i in (0...array.count / 2 - 1).reversed() {
            sink(&array, i, array.count)
        }
        // 将最大的元素与最后一个元素交换，然后修复
        for i in (1..<array.count).reversed() {
            swap(&array[0], &array[i])
            sink(&array, 0, i-1)
        }
    }
    
    func sink(_ array: inout [Int], _ index: Int, _ n: Int) {
        var parentIndex = index
        while 2*parentIndex + 2 < n {
            let leftChildIndex = 2*parentIndex + 1
            let rightChildIndex = 2*parentIndex + 2
            
            var next = parentIndex
            if leftChildIndex < n && array[leftChildIndex] > array[next] {
                next = leftChildIndex
            }
            if rightChildIndex < n && array[rightChildIndex] > array[next] {
                next = rightChildIndex
            }
            if next == parentIndex { break }
            
            swap(&array[parentIndex], &array[next])
            parentIndex = next
        }
    }
}

var array = [2,3,4,6,1,2,8,0]
//HeapSort().sort(&array)
HeapSort().sortInPlace(&array)
