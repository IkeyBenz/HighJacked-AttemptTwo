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
   
    
    
    
    override func update(delta: CCTime) {
        scoreLabel.string = String(Enemy.score)
        updatedHeliScale()
        updatedHeliSpeed()
        updatedHeliSpawn()
        
        var randomSpawn = arc4random_uniform(1000)
        var randomReverseSpawn = arc4random_uniform(1000)
        
        if randomSpawn < updatedHeliSpawn() {
            showHelicopters(updatedHeliScale(), heliSpeed: updatedHeliSpeed())
        } else if randomReverseSpawn < updatedHeliSpawn() {
            showReverseHelicopters(updatedHeliScale(), heliSpeed: updatedHeliSpeed())
        }
        
        
    }
    
    func showHelicopters(heliScale: Double, heliSpeed: Double) {
        
        println(heliSpeed)
        
        var helicopter = CCBReader.load("Helicopter") as! Helicopter
        
        var randomHeight = arc4random_uniform(190) + 100
        
        helicopter.scale = Float(heliScale)
        helicopter.position = CGPoint(x: CGFloat(600), y: CGFloat(randomHeight))
        addChild(helicopter)
        
        
        helicopter.moveHelicopter(heliSpeed)
        
        
    }
    
    func showReverseHelicopters(heliScale: Double, heliSpeed: Double) {
        
        println("\(heliSpeed) reverse")
        var reverseHelicopter = CCBReader.load("ReverseHelicopter") as! ReverseHelicopter
        
        var randomHeight = arc4random_uniform(190) + 100
        
        reverseHelicopter.scale = Float(heliScale)
        reverseHelicopter.position = CGPoint(x: -100, y: CGFloat(randomHeight))
        addChild(reverseHelicopter)
        
        reverseHelicopter.moveHelicopter(heliSpeed)
    }
    
    func updatedHeliScale() -> Double {
        var currentHelicopterScale: Double!
        
        currentHelicopterScale = 3.0
        if Enemy.score >= 20 && Enemy.score < 100 {
            currentHelicopterScale = 2.7
        } else if Enemy.score >= 100 && Enemy.score < 200 {
            currentHelicopterScale = 2.5
        } else if Enemy.score >= 200 && Enemy.score < 300 {
            currentHelicopterScale = 2
        } else if Enemy.score >= 300 && Enemy.score < 400 {
            currentHelicopterScale = 1.7
        } else if Enemy.score >= 400 && Enemy.score < 450 {
            currentHelicopterScale = 1.3
        } else if Enemy.score >= 450 {
            currentHelicopterScale = 1
        }
        
        return currentHelicopterScale
    }
    
    func updatedHeliSpeed() -> Double {
        var speed: Double!
        if Enemy.score >= 0 && Enemy.score < 20 {
            speed = 5
        }
        if Enemy.score >= 20 && Enemy.score < 100 {
            speed = 4.5
        } else if Enemy.score >= 100 && Enemy.score < 200 {
            speed = 4.2
        } else if Enemy.score >= 200 && Enemy.score < 300 {
            speed = 4
        } else if Enemy.score >= 300 && Enemy.score < 400 {
            speed = 3.7
        } else if Enemy.score >= 400 && Enemy.score < 450 {
            speed = 3.2
        } else if Enemy.score >= 450 {
            speed = 3
        }
        return speed
    }
    
    func updatedHeliSpawn() -> UInt32 {
        var randomSpawnProbability: UInt32 = 5
        if Enemy.score >= 20 && Enemy.score < 100 {
            randomSpawnProbability = 7
        } else if Enemy.score >= 100 && Enemy.score < 200 {
            randomSpawnProbability = 7
        } else if Enemy.score >= 200 && Enemy.score < 300 {
            randomSpawnProbability = 8
        } else if Enemy.score >= 300 && Enemy.score < 400 {
            randomSpawnProbability = 9
        } else if Enemy.score >= 400 && Enemy.score < 450 {
            randomSpawnProbability = 10
        } else if Enemy.score >= 450 {
            randomSpawnProbability = 11
        }
        
        return randomSpawnProbability
    }
    
}