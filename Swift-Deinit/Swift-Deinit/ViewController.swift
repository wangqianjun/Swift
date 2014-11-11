//
//  ViewController.swift
//  Swift-Deinit
//
//  Created by 王钱钧 on 14/11/11.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        testDeinit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


struct Bank {
    static var coinsInBank = 10_000
    static func vendCoins(var numberOfCoinsToVend: Int) -> Int {
        numberOfCoinsToVend = min(numberOfCoinsToVend, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func receiveConins(coins: Int) {
        coinsInBank += coins
    }
}


class Player {
    var coinsInPures: Int
    init(coins: Int) {
        coinsInPures = Bank.vendCoins(coins)
    }
    
    func winCoins(coins: Int) {
        coinsInPures += Bank.vendCoins(coins)
    }
    
    deinit {
        Bank.receiveConins(coinsInPures)
    }
}

func testDeinit() {
    var playerOne: Player? = Player(coins: 100)
    println("A new player has joined the game with \(playerOne?.coinsInPures)")
    println("There are now \(Bank.coinsInBank) coins left in the bank")
    playerOne?.winCoins(2_000)
    println("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPures)")
    println("There are now \(Bank.coinsInBank) coins left in the bank")
    
    //此时调用deinit方法
    playerOne = nil
    
    println("PlayerOne has left the game")
    println("The bank now has \(Bank.coinsInBank)")
}