//: Playground - noun: a place where people can play

import UIKit

/*:
函数格式:
 - func 函数名(参数列表) -> 返回值 { // 代码实现 }
 - 调用函数: 函数名(实参, 形参: 实参)
 - -> 是 Swift 特有的, 表示前面的执行结果, 输出给后面
*/
func sum(num1: Int, num2: Int) -> Int {
    return num1 + num2
}

//: 首参数名省略
sum(10, num2: 20)

//: 外部参数, 形参前, 供外部调用, 判断语义
func sum1(num1 x: Int, num2 y: Int) -> Int {
    return x + y
}
sum1(num1: 30, num2: 50)

//: 函数重载, 函数名相同, 参数类型和数量不同
func sum1(x: Double, y: Double) -> Double {
    return x + y
}
sum1(10.5, y: 9.5)

/*:
没有返回值的三种情况
 - void
 - ()
 - 完全省略
*/
func demo(string: String) -> Void {
    print(string)
}
demo("haha")

func demo1(string: String) -> () {
    print(string)
}
demo("hehe")

func demo2(string: String) {
    print(string)
}
demo("xixi")

