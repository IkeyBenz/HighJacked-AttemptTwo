//
//  Helicopter.swift
//  HighJacked_AttemptTwo
//
//  Created by Ikey Benzaken on 7/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Helicopter: CCSprite {

    
    var move: CCActionMoveTo!
    
    func moveHelicopter(speed: Double) {
        
        var callblock = CCActionCallBlock(block: {self.checkForEnemies()})
        move = CCActionMoveTo(duration: speed, position: ccp(CGFloat(-50 - Double(contentSizeInPoints.width) * Double(scale)), position.y))
        runAction(CCActionSequence(array: [move, callblock]))
        
    }
    func checkForEnemies() {
        var doesHaveEnemies: Bool!
        if children.count > 1 {
            triggerGameOver()
        } else {
            removeFromParent()
        }

    }
    
    func triggerGameOver() {
        Enemy.score = 0
        self.stopAllActions()
        CCDirector.sharedDirector().presentScene(CCBReader.loadAsScene("MainScene"))
    }
    
   
    
    
}