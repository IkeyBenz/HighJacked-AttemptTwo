//
//  Gameplay.swift
//  HighJacked_AttemptTwo
//
//  Created by Ikey Benzaken on 7/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Gameplay: CCScene, CCPhysicsCollisionDelegate {
    
    weak var scoreLabel: CCLabelTTF!
    weak var gamePhysicsNode: CCPhysicsNode!
    weak var coinDeleter: CCNode!
    
    
    func didLoadFromCCB() {
        gamePhysicsNode.collisionDelegate = self
        multipleTouchEnabled = true
    }
    
    override func update(delta: CCTime) {
        scoreLabel.string = String(Enemy.score)
        updateEverything()
        
        var randomSpawn = arc4random_uniform(1000)
        var randomReverseSpawn = arc4random_uniform(1000)
        var randomCoinXposition = arc4random_uniform(500) + 20
        
        if Enemy.score < 50 {
            if randomSpawn < updatedSpawnProbability {
                showHelicopters(updatedHeliScale, heliSpeed: updatedHeliSpeed)
            } else if randomReverseSpawn < updatedSpawnProbability {
                showReverseHelicopters(updatedHeliScale, heliSpeed: updatedHeliSpeed)
            }
        }
        if Enemy.score >= 50 {
            if randomSpawn < updatedSpawnProbability {
                showBlackHelicopters(updatedHeliScale, heliSpeed: updatedHeliSpeed)
            } else if randomReverseSpawn < updatedSpawnProbability {
                showReverseBlackHelicopters(updatedHeliScale, heliSpeed: updatedHeliSpeed)
            }
        }
        
        if randomSpawn < 1 {
            var coinPosition = CGPoint(x: Double(randomCoinXposition), y: 650)
            coinAppear(coinPosition)
        }
        
        
    }
    
    func showHelicopters(heliScale: Double, heliSpeed: Double) {
        
        println(heliSpeed)
        
        var helicopter = CCBReader.load("Helicopters/Helicopter") as! Helicopter
        
        var randomHeight = arc4random_uniform(190) + 100
        
        helicopter.scale = Float(heliScale)
        helicopter.position = CGPoint(x: CGFloat(600), y: CGFloat(randomHeight))
        addChild(helicopter)
        
        
        helicopter.moveHelicopter(heliSpeed)
        
    }
    
    func showReverseHelicopters(heliScale: Double, heliSpeed: Double) {
        
        var reverseHelicopter = CCBReader.load("Helicopters/ReverseHelicopter") as! ReverseHelicopter
        
        var randomHeight = arc4random_uniform(190) + 100
        
        reverseHelicopter.scale = Float(heliScale)
        reverseHelicopter.position = CGPoint(x: -100, y: CGFloat(randomHeight))
        addChild(reverseHelicopter)
        
        reverseHelicopter.moveHelicopter(heliSpeed)
    }
    
    
    
    func showBlackHelicopters(heliScale: Double, heliSpeed: Double) {
        
        var blackHelicopter = CCBReader.load("Helicopters/BlackHelicopter") as! BlackHelicopter
        var randomHeight = arc4random_uniform(190) + 100
        
        blackHelicopter.scale = Float(heliScale)
        blackHelicopter.position = CGPoint(x: 600, y: CGFloat(randomHeight))
        addChild(blackHelicopter)
        
        blackHelicopter.moveHelicopter(heliSpeed)
    }
    
    func showReverseBlackHelicopters(heliScale: Double, heliSpeed: Double) {
        
        var reverseBlackHelicopter = CCBReader.load("Helicopters/ReverseBlackHelicopter") as! ReverseBlackHelicopter
        var randomHeight = arc4random_uniform(190) + 100
        
        reverseBlackHelicopter.scale = Float(heliScale)
        reverseBlackHelicopter.position = CGPoint(x: -100, y: CGFloat(randomHeight))
        addChild(reverseBlackHelicopter)
        
        reverseBlackHelicopter.moveHelicopter(heliSpeed)
    }
    
    func coinAppear(CPosition: CGPoint) {
        if Enemy.score > 50 {
            var coin = CCBReader.load("Coins") as! Coins
            coin.position = CPosition
            coin.scale = 0.7
            gamePhysicsNode.addChild(coin)
        }
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, coin: CCNode!, coinDeleter: CCNode!) -> Bool {
        coin.removeFromParent()
        return true
    }
    
    var updatedHeliSpeed: Double!
    var updatedHeliScale: Double!
    var updatedSpawnProbability: UInt32!
    
    func updateEverything() {
        if Enemy.score < 20 {
            
            updatedHeliSpeed = 5
            updatedHeliScale = 3.0
            updatedSpawnProbability = 5
            
        } else if Enemy.score >= 20 && Enemy.score < 100 {
            
            updatedHeliSpeed = 4.5
            updatedHeliScale = 2.5
            updatedSpawnProbability = 6

        } else if Enemy.score >= 100 && Enemy.score < 200 {
            
            updatedHeliSpeed = 4.3
            updatedHeliScale = 2.2
            updatedSpawnProbability = 7

        } else if Enemy.score >= 200 && Enemy.score < 300 {
            
            updatedHeliSpeed = 4.0
            updatedHeliScale = 2.0
            updatedSpawnProbability = 8

        } else if Enemy.score >= 300 && Enemy.score < 450 {
            
            updatedHeliSpeed = 3.7
            updatedHeliScale = 1.7
            updatedSpawnProbability = 9

        } else if Enemy.score >= 450 {
            
            updatedHeliSpeed = 3.5
            updatedHeliScale = 1.5
            updatedSpawnProbability = 11
            
        }
    }
    

}