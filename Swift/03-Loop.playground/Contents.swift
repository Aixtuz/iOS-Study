//: Playground - noun: a place where people can play

import UIKit

//: 传统写法
for var i = 0; i < 10; i++ {
    print(i)
}

//: Swift写法1
for i in 0..<10 {
    print(i)
}

//: Swift写法2
for i in 0...10 {
    print(i)
}

// 无索引写法
for _ in 0...10 {
    print("hello")
}