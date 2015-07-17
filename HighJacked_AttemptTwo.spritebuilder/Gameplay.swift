//
//  Gameplay.swift
//  HighJacked_AttemptTwo
//
//  Created by Ikey Benzaken on 7/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Gameplay: CCScene/*, EnemyDelegate*/ {
    
        weak var scoreLabel: CCLabelTTF!
    var currentHelicopterScale: Float = 3.0
    
    override func update(delta: CCTime) {
        var randomSpawn = arc4random_uniform(1000)
        var randomReverseSpawn = arc4random_uniform(1000)
        scoreLabel.string = String(Enemy.score)
        
        if randomSpawn < 10 {
            showHelicopters()
        } else if randomReverseSpawn < 10 {
            showReverseHelicopters()
        }
        
    }
    
    func showHelicopters() {
        
        if Enemy.score > 50 {
            currentHelicopterScale = 1.8
        } else if Enemy.score > 100 {
            currentHelicopterScale = 1.4
        } else if Enemy.score > 150 {
            currentHelicopterScale = 1.2
        } else if Enemy.score > 200 {
            currentHelicopterScale = 0.8
        } else if Enemy.score > 250 {
            currentHelicopterScale = 0.5
        }
        
        
        var helicopter = CCBReader.load("Helicopter") as! Helicopter
        
        var randomHeight = arc4random_uniform(190) + 100
        
        helicopter.scale = currentHelicopterScale
        helicopter.position = CGPoint(x: CGFloat(600), y: CGFloat(randomHeight))
        addChild(helicopter)
        
        
        helicopter.moveHelicopter()
        
        
    }
    
    func showReverseHelicopters() {
        
        if Enemy.score > 50 {
            currentHelicopterScale = 1.8
        } else if Enemy.score > 100 {
            currentHelicopterScale = 1.4
        } else if Enemy.score > 150 {
            currentHelicopterScale = 1.2
        } else if Enemy.score > 200 {
            currentHelicopterScale = 0.8
        } else if Enemy.score > 250 {
            currentHelicopterScale = 0.5
        }

        
        
        var reverseHelicopter = CCBReader.load("ReverseHelicopter") as! ReverseHelicopter
        
        var randomHeight = arc4random_uniform(190) + 100
        
        reverseHelicopter.scale = currentHelicopterScale
        reverseHelicopter.position = CGPoint(x: -100, y: CGFloat(randomHeight))
        addChild(reverseHelicopter)
        
        reverseHelicopter.moveHelicopter()
    }
    
    
}