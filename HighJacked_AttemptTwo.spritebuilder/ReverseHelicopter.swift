//
//  ReverseHelicopter.swift
//  HighJacked_AttemptTwo
//
//  Created by Ikey Benzaken on 7/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

var GAMEOVER: Bool!
class ReverseHelicopter: Helicopter {
    
    var screenWidth = UIScreen.mainScreen().bounds.width
    
    override func moveHelicopter(speed: Double) {
        var delay = CCActionDelay(duration: speed)
     //   var callblock = CCActionCallBlock(block: {self.checkForEnemies()})
        move = CCActionMoveTo(duration: speed, position: ccp(CGFloat((Double(screenWidth) + Double(contentSizeInPoints.width / 2) * Double(scale))) - 100, position.y))
        runAction(CCActionSequence(array: [move, delay]))
        
        alreadyMoved = true
    }

    
    
    
    
    
    
    //    weak var enemy: Enemy!
    //    var move: CCActionMoveTo!
    
    
//    
//    func triggerGameOver() {
//        GAMEOVER = true
////        GAMEPLAY.stopAllActions()
////        stopAllActions()
//        removeFromParent()
//        GAMEPLAY.animationManager.runAnimationsForSequenceNamed("Game Over Label")
//        //CCDirector.sharedDirector().presentScene(CCBReader.loadAsScene("MainScene"))
//    }
//    
    
    
    
    
    //    func checkForEnemies() {
    //        var doesHaveEnemies: Bool!
    //        if children.count > 1 {
    //            enemy.wasKilled = true
    //            enemy.isShooting = false
    //            Gameplay.life -= Float(100)
    //            if Gameplay.life == 0 {
    //                triggerGameOver()
    //            }
    //        } else {
    //            removeFromParent()
    //        }
    //    }
    
    
}