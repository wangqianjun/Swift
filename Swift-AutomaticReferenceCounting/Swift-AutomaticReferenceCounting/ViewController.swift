//
//  ViewController.swift
//  Swift-AutomaticReferenceCounting
//
//  Created by 王钱钧 on 14/11/11.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

import UIKit

var reference: Person?
var arthur: Person?
var number17: Apartment?
var doris: Customer?
var country: Country?
var paragraph:HTMLElement?

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        testARC()

        // 调用析构函数
        reference = nil;
        testStrongReferenceCyclesBetweenClass()
        
        // 由于Person类和Apartment类相互之间形成了循环强引用，即使将类实例赋值为nil也不能释放内存，造成内存泄露
        arthur = nil
        number17 = nil
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//=====================1 自动引用计数的工作机制

//=====================2 自动引用计数实践
class Person {
    let name: String
    init(name: String) {
        self.name = name
        println("\(name) is being initialized")
    }
    
    // 测试循环强引用
    var apartment: Apartment?
    
    deinit {
        println("\(name) is being deinitialized")
    }
    
}

func testARC() {
    var reference1: Person?
    var reference2: Person?
    var reference3: Person?
    
    reference1 = Person(name: "Arthur Wang")
    
    //生成强引用
    reference2 = reference1;
    reference = reference1;
    
}

//=====================3 类实例之间的循环强引用
/*
一个类永远不会有0个强引用，这种情况发生在两个类的实例相互保持对方的强引用，并让对方不被销毁

*/
class Apartment {
    let number: Int
    init(number: Int) {
        self.number = number
        println("Apartment #\(number) is being initialized")
    }
//    var tenant: Person?
//    使用弱引用
    weak var tenant: Person?
    
    deinit { println("Apartment #\(number) is being deinitialized") }
}

func testStrongReferenceCyclesBetweenClass() {
    arthur = Person(name: "Arthur Wang")
    number17 = Apartment(number: 17)
    
    arthur!.apartment = number17
    number17!.tenant = arthur
    
    doris = Customer(name: "Doris Wu")
    doris!.card = CreditCard(number: 88, customer: doris!)
    
    country = Country(name: "China", capitalName: "Beijing")
    
    paragraph = HTMLElement(name: "p", text: "hello World")
//    println(paragraph!.asHTML())
    println(paragraph!.asHTMLHasCaptureList())
    //闭包与实例之间形成循环强引用
    paragraph = nil
    
}

//=====================4 解决实例之间的循环强引用
/*
Swift提供两种办法解决循环强引用的问题
1）弱引用（weak reference）
    弱引用不会牢牢保持住引用的实例，并且不会阻止ARC销毁被引用的实例，所以可以将Apartment中得tenant设置为weak
2）无主引用（unowned reference）
    和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是无主引用是永远有值的（不能为可选类型）

两个属性的值都允许为nil，并会潜在的产生循环强引用，这种场景最适合用弱引用来解决
两个属性的值有个不允许为nil，并会潜在的产生循环强引用，这种场景最适合用无主引用来解决
两个属性的值都不允许为nil，并会潜在的产生循环强引用，这种场景需要一个类使用无主属性，而另外一个类使用隐式解析可选属性（!）

*/

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
        println("\(name) is being initialized")
    }
    deinit { println("\(name) is being deinitialized") }
}

class CreditCard {
    let number: Int
    
    //无主引用不能为空
    unowned let customer: Customer
    init(number: Int, customer: Customer) {
        self.number = number
        self.customer = customer
        println("Card #\(number) is being initialized")
    }
    deinit { println("Card #\(number) is being deinitialized") }
}

//针对第三种场景有如下例子
class Country {
    let name: String
    let capitalCity: City! // 隐式解析可选属性
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

//=====================5 闭包引起的循环强引用
/*
循环强引用还会发生在当你将一个闭包赋值给类实例的某个属性，并且这个闭包体重又使用了实例。（因为闭包和类相似，都是引用类型）
*/
class HTMLElement {
    let name: String
    let text: String?
    
    // 该属性引用一个闭包（一个没有参数，返回类型为String的函数）
//    lazy var asHTML:() -> String = {
//        if let text = self.text {
//            return "<\(self.name)>\(text)</\(self.name)>"
//        } else {
//            return"<\(self.name)/>"
//        }
//    }
    
    lazy var asHTMLHasCaptureList:() -> String = {
//        [unowned self] (index: Int, stringToProcess: String) -> String in
        [unowned self] in // 用无主引用而不是强引用来捕获self
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return"<\(self.name)/>"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        println("\(name) is being deinitialized")
    }
    
    
}

//=====================6 解决闭包引起的循环强引用
/*
在定义闭包时定义捕获列列表作为闭包的一部分，通过这种方式可以解决闭包和类实例之间的循环强引用。
*/

//定义捕获列表
//捕获列表中得每个元素都是由weak或者unowned关键字和实例引用（self或者someInstance）成对组成
//每一对都在方括号中【】，通过逗号分开

