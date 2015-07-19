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
    
    var screenWidth = UIScreen.mainScreen().bounds.width
    
    func moveHelicopter(heliSpeed: Double) {
        
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