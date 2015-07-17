//
//  ReverseHelicopter.swift
//  HighJacked_AttemptTwo
//
//  Created by Ikey Benzaken on 7/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class ReverseHelicopter: CCSprite {

    var move: CCActionMoveTo!
    var heliSpeed: Double = 5
    
    var screenWidth = UIScreen.mainScreen().bounds.width
    
    func moveHelicopter() {
        
        if Enemy.score > 25 {
            heliSpeed = 4.5
        } else if Enemy.score > 75 {
            heliSpeed = 4
        } else if Enemy.score > 125 {
            heliSpeed = 3.5
        } else if Enemy.score > 150 {
            heliSpeed = 3
        }
        
        var callblock = CCActionCallBlock(block: {self.checkForEnemies()})
        move = CCActionMoveTo(duration: heliSpeed, position: ccp(CGFloat(Double(screenWidth) + Double(contentSizeInPoints.width / 2) * Double(scale)), position.y))
        runAction(CCActionSequence(array: [move, callblock]))
        
    }
    func checkForEnemies() {
        var doesHaveEnemies: Bool!
        if children.count > 1 {
            triggerGameOver()
        } else if children.count == 1 {
            removeFromParent()
        }
    }
    
    func triggerGameOver() {
        Enemy.score = 0
        self.stopAllActions()
        CCDirector.sharedDirector().presentScene(CCBReader.loadAsScene("MainScene"))
    }
    
    
}