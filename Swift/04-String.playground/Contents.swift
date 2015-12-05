//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground!"

/*:
Swift, 字符串默认 String, 非 NSString
 - String 结构体, 效率高, 支持快速遍历
 - NSString 继承 NSObject, 不支持快速遍历
*/

//: 快速遍历字符串
for c in str.characters {
    print(c)
}

let i = 100
let view = UIView()
view.backgroundColor = UIColor.cyanColor()
let frame = CGRectMake(50, 50, 100, 100)

//: 字符串拼接
let str1 = str + " " + "I'm coming!"
print(str1 + "\(i) abc \(view.backgroundColor)")

//: 在 "" 中用 \(变量名) 快速拼接字符串
print("区域: \(frame)")

//: 格式拼接
let str2 = String(format: "%02d:%02d:%02d", arguments: [1, 5, 10])

//: Swift 中结合 range 使用的字符串, 先转 NSString 更方便
let myString: NSString = "hello"
myString.substringWithRange(NSMakeRange(1, 4))


