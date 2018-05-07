/*
 251. Flatten 2D Vector
 https://leetcode.com/problems/flatten-2d-vector/description/
 
 Implement an iterator to flatten a 2d vector.
 
 For example,
 Given 2d vector =
 
 [
 [1,2],
 [3],
 [4,5,6]
 ]
 By calling next repeatedly until hasNext returns false, the order of elements returned by next should be: [1,2,3,4,5,6].
 makeIterator
 Follow up:
 As an added challenge, try to code it using only iterators in C++ or iterators in Java.
 
 */

/**
 * Your Vector2D object will be instantiated and called as such:
 * Vector2D i = new Vector2D(vec2d);
 * while (i.hasNext()) v[f()] = i.next();
 */

// swift IteratorProtocol
public struct Vector2D<Element>: Sequence {
    
    let vec2d: [[Element]]
    
    init(vec2d: [[Element]]) {
        self.vec2d = vec2d
    }
    
    public func makeIterator() -> Vector2DIterator<Element> {
        return Vector2DIterator(vec2d: self.vec2d)
    }
    
    public struct Vector2DIterator<Element>: IteratorProtocol {
//        public typealias Element = Int
        
        let vec2d: [[Element]]
        
        init(vec2d: [[Element]]) {
            self.vec2d = vec2d
        }
        var row = 0
        var colum = 0
        mutating public func next() -> Vector2D.Vector2DIterator<Element>.Element? {
//            if row < vec2d.count {
//                if colum < vec2d[row].count {
//                    let temp = vec2d[row][colum]
//                    colum += 1
//                    return temp
//                } else {
//                    row += 1
//                    colum = 0
//                    return next()
//                }
//            }
            while row < vec2d.count {
                if colum < vec2d[row].count {
                    let temp = vec2d[row][colum]
                    colum += 1
                    return temp
                } else {
                    row += 1
                    colum = 0
                }
            }
            return nil
        }
    }
}

let vec2d =  [
    [1,2],
    [3],
    [4,5,6]
]
let vector2d = Vector2D(vec2d: vec2d)
var i = vector2d.makeIterator()
while let value = i.next() {
    //    print(value)
}
//for value in vector2d {
//    print(value)
//}


// hasNext
public struct Vector2D_2<Element> {
    
    let vec2d: [[Element]]
    
    init(vec2d: [[Element]]) {
        self.vec2d = vec2d
    }
    
    var row = 0
    var colum = 0
    
    mutating public func hasNext() -> Bool {
        while row < vec2d.count {
            if colum < vec2d[row].count {
                return true
            } else {
                row += 1
                colum = 0
            }
        }
        return false
    }
    
    mutating public func next() -> Element {
        let temp = vec2d[row][colum]
        colum += 1
        return temp
    }
}

//var vector2d_2 = Vector2D_2(vec2d: vec2d)
//while vector2d_2.hasNext() {
//    print(vector2d_2.next())
//}

// iterator
public struct Vector2D_3<Element> {
    
    let vec2d: [[Element]]
    
    init(vec2d: [[Element]]) {
        self.vec2d = vec2d
    }
    
    public func makeIterator() -> Vector2DIterator<Element> {
        return Vector2DIterator(vec2d: self.vec2d)
    }
    
    public struct Vector2DIterator<Element>: IteratorProtocol {
        
        let vec2d: [[Element]]
        var i: IndexingIterator<[[Element]]>
        var j: IndexingIterator<[Element]>?
        
        init(vec2d: [[Element]]) {
            self.vec2d = vec2d
            self.i = vec2d.makeIterator()
            self.j = i.next()?.makeIterator()
        }
        
        mutating public func next() -> Vector2D_3.Vector2DIterator<Element>.Element? {
//            if let value = j?.next() {
//                return value
//            }
//            if let ii = i.next() {
//                j = ii.makeIterator()
//                return next()
//            }
            // 注意这里不能将j重新赋值给别的变量，会值拷贝
            while j != nil {
                if let value = j?.next() {
                    return value
                }
                j = i.next()?.makeIterator()
            }
            
            return nil
        }
    }
}

var vector2d_3 = Vector2D_3(vec2d: vec2d)
var i_3 = vector2d_3.makeIterator()
while let value = i_3.next() {
    print(value)
}
