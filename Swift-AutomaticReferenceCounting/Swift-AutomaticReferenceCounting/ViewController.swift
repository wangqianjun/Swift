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
//=====================6 解决闭包引起的循环强引用