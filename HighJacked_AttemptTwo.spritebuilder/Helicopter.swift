//
//  Helicopter.swift
//  HighJacked_AttemptTwo
//
//  Created by Ikey Benzaken on 7/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Helicopter: CCSprite {
    var randomHeight = arc4random_uniform(190) + 100
    enum Side {
        case Left, Right
    }
    var state: Side! {
        didSet {
            if state == .Left {
                flipX = true
                position = ccp(CGFloat(Double(-contentSize.width) / 2 * Double(scale), Double(randomHeight)))
            } else if state == .Right {
                
            }
            
        }
    }
    
    func setStuff() {
        
    }
    
    
    
    
    weak var enemy: Enemy!
    var move: CCActionMoveTo!
    var alreadyMoved: Bool = false
    
    func moveHelicopter(speed: Double) {
        var callblock = CCActionCallBlock(block: {self.alreadyMoved = true})
        var delay = CCActionDelay(duration: speed)
      //  var callblock = CCActionCallBlock(block: {self.checkForEnemies()})
        move = CCActionMoveTo(duration: speed, position: ccp(CGFloat(-Double(contentSizeInPoints.width) * 0.5 * Double(scale)), position.y))
        runAction(CCActionSequence(array: [move, callblock]))
    }
    
    func setAlreadyMovedBoolean() {
        alreadyMoved = true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func checkForEnemies() {
//        var doesHaveEnemies: Bool!
//        if children.count > 1 {
//            enemy.wasKilled = true
//            enemy.isShooting = false
//            Gameplay.life -= Float(100)
//            removeFromParent()
//            
//            
//            
//            if Gameplay.life == 0 {
//                Gameplay.triggerGameOver())
//            }
//        } else {
//            removeFromParent()
//        }
//    }
//    

    
    
    
    
}
