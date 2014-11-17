//
//  ViewController.swift
//  Swift-Closures
//
//  Created by 王钱钧 on 14/11/14.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        sortedArray()
        trailingClosure()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//===============1 闭包表达式 Closure Expressions
/*
闭包是自包含的函数代码块，类似Block
闭包采取如下三种形式之一：
1）全局函数是一个有名字但不会捕获任何值的闭包
2）嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
3）闭包表达式是一个利用轻量级语法所写的可以捕获上下文中变量或常量值得匿名闭包
*/

let names = ["Arthur", "Christ", "Redding", "DK"]

func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}

func sortedArray() {
    var reversed = sorted(names, backwards)
//    reversed = sorted(names, {(s1: String, s2: String) -> Bool in return s1 > s2}) // 完整格式
//    reversed = sorted(names, {s1, s2 in  s1 > s2}) // 实际上任何情况下，通过内联闭包表达式构造的闭包作为参数传递给函数时，都可以推断出闭包的参数返回值类型，单表达式闭包隐式返回
    
//    reversed = sorted(names, { $0 > $1 }) // 参数名称缩写
    reversed = sorted(names, >) // 运算符参数
    println(reversed)
}

//闭包表达式语法：(闭包的函数部分由关键字 in 引入)
//{(parameters) -> returnType in
//    statements
//}


//===============2 尾随闭包   Trailing Closure
/*
如果需要将一个很长的闭包表达式作为一个参数传递给函数，可以使用尾随闭包来增强函数可读性
尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个函数参数调用
*/

func trailingClosure() {
    let digitNames = [0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four", 5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"]
    let numbers = [16, 58, 510]
    let strings = numbers.map{
        (var number) -> String in
        var output = ""
        while number > 0 {
            output = digitNames[number % 10]! + output
            number /= 10
        }
        return output
    }
    
    println(strings)
}

//===============3 值捕获     Capturing Values


//===============4 闭包是引用类型 Closure Are Reference Types
