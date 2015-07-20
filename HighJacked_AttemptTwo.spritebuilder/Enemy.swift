//
//  Enemy.swift
//  HighJacked_AttemptTwo
//
//  Created by Ikey Benzaken on 7/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Enemy: CCSprite, CCPhysicsCollisionDelegate {
    static var score: Int = 0
    
    func didLoadFromCCB() {
        userInteractionEnabled = true
        
    }
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        var randomScoreIncrease = arc4random_uniform(5)
        Enemy.score += Int(randomScoreIncrease)
        removeFromParent()
        
    }

}

