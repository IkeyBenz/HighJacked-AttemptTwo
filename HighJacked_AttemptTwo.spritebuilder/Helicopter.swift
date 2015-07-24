//
//  Helicopter.swift
//  HighJacked_AttemptTwo
//
//  Created by Ikey Benzaken on 7/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Helicopter: CCSprite {
    
    weak var enemy: Enemy!
    var move: CCActionMoveTo!
    var alreadyMoved: Bool = false
    
    func moveHelicopter(speed: Double) {
        var callblock = CCActionCallBlock(block: {self.setAlreadyMovedBoolean()})
        var delay = CCActionDelay(duration: speed)
      //  var callblock = CCActionCallBlock(block: {self.checkForEnemies()})
        move = CCActionMoveTo(duration: speed, position: ccp(CGFloat((Double(contentSizeInPoints.width) * Double(scale)) - 100), position.y))
        runAction(CCActionSequence(array: [move, delay, callblock]))
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
