//
//  Coins.swift
//  HighJacked_AttemptTwo
//
//  Created by Ikey Benzaken on 7/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Coins: CCSprite {
    
    func didLoadFromCCB() {
        userInteractionEnabled = true
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        removeFromParent()
        Enemy.score += 10
    }
    
}