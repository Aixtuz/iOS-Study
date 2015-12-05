//: Playground - noun: a place where people can play

import UIKit

//: 函数定义
func sum(num1 x: Int, num2 y: Int) -> Int {
    return x + y
}
sum (num1: 10, num2: 20)

//: 定义一个变量记录函数, 可作参数传递, 可作返回值
let sumParam = sum
sumParam(num1: 20, num2: 30)

/*:
闭包 Closure 和 Block 很像
 - 预先准备代码块, 需要时执行
 - 可作参数传递
 - 包含 self, 注意循环引用问题
 - Swift 中,函数本身就可作参数和返回值
*/

/*:
格式:
{ (形参) -> 返回值类型 in 代码实现 }
> in关键字类似于定义和执行代码之间的分隔符
*/
let sumFunc: (num1: Int, num2: Int) -> Int = { (x, y) -> Int in
    return x + y
}
sumFunc(num1: 1, num2: 2)

//: 最简单的闭包, 没有参数, 没有返回值, 连 in 都省了
let demoFunc = {
    print("hello")
}
// 定义一个变量指向闭包
let a = demoFunc
// 执行闭包
a()

