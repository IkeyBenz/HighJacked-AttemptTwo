//
//  Enemy.swift
//  HighJacked_AttemptTwo
//
//  Created by Ikey Benzaken on 7/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Enemy: CCSprite {
    
    static var score: Int = 0
    var isShooting: Bool = false
    var wasKilled: Bool = false
    
    var delegate: EnemyDelegate!
    
    func didLoadFromCCB() {
        userInteractionEnabled = true
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        var randomScoreIncrease = arc4random_uniform(5) + 2
        delegate.enemyKilled(Int(randomScoreIncrease))
        self.isShooting = false
        self.wasKilled = true
//        println("Killed enemy's isShooting = \(self.isShooting)")
        removeFromParent()
    }
    
}

protocol EnemyDelegate{
    func enemyKilled(score: Int)
}