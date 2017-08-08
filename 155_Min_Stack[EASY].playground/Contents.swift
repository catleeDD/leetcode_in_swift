/*
 155. Min Stack
 https://leetcode.com/problems/min-stack/#/description
 
 Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.
 
 push(x) -- Push element x onto stack.
 pop() -- Removes the element on top of the stack.
 top() -- Get the top element.
 getMin() -- Retrieve the minimum element in the stack.
 Example:
 MinStack minStack = new MinStack();
 minStack.push(-2);
 minStack.push(0);
 minStack.push(-3);
 minStack.getMin();   --> Returns -3.
 minStack.pop();
 minStack.top();      --> Returns 0.
 minStack.getMin();   --> Returns -2.
 
 */

// two stack
class MinStack {
    private var stack = [Int]()
    private var minStack = [Int]()
    
    func push(_ x: Int) {
        stack.append(x)
        if minStack.isEmpty || x <= getMin()! {
            minStack.append(x)
        }
    }
    
    func pop() {
        if stack.last == getMin() {
            minStack.popLast()
        }
        stack.popLast()
    }
    
    func top() -> Int? {
        return stack.last
    }
    
    func getMin() -> Int? {
        return minStack.last
    }
}

let minStack = MinStack()
minStack.push(-2)
minStack.push(0)
minStack.push(-3)
minStack.getMin() //   --> Returns -3.
minStack.pop()
minStack.top() //      --> Returns 0.
minStack.getMin() //   --> Returns -2.


// 只用一个stack，很巧妙
class MinStack1 {
    private var min = Int.max
    private var stack = [Int]()
    
    func push(_ x: Int) {
        if x <= min {
            stack.append(min)
            min = x
        }
        stack.append(x)
    }
    
    func pop() {
        if stack.popLast() == min {
            min = stack.popLast() ?? Int.max
        }
    }
    
    func top() -> Int? {
        return stack.last
    }
    
    func getMin() -> Int? {
        return min
    }
}

let minStack1 = MinStack1()
minStack1.push(-2)
minStack1.push(0)
minStack1.push(-3)
minStack1.getMin() //   --> Returns -3.
minStack1.pop()
minStack1.top() //      --> Returns 0.
minStack1.getMin() //   --> Returns -2.

