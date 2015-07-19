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
        
        var randomSpawn = arc4random_uniform(1000)
        var randomReverseSpawn = arc4random_uniform(1000)
        
        if randomSpawn < 5 {
            showHelicopters(updatedHeliScale(), speed: updatedHeliSpeed())
        } else if randomReverseSpawn < 5 {
            showReverseHelicopters(updatedHeliScale(), speed: updatedHeliSpeed())
        }
        
        
    }
    
    func showHelicopters(heliScale: Float, speed: Double) {
        println(heliScale)
        
        var helicopter = CCBReader.load("Helicopter") as! Helicopter
        
        var randomHeight = arc4random_uniform(190) + 100
        
        helicopter.scale = heliScale
        helicopter.position = CGPoint(x: CGFloat(600), y: CGFloat(randomHeight))
        addChild(helicopter)
        
        
        helicopter.moveHelicopter(speed)
        
        
    }
    
    func showReverseHelicopters(heliScale: Float, speed: Double) {
        println("\(heliScale) reverse")
        
        var reverseHelicopter = CCBReader.load("ReverseHelicopter") as! ReverseHelicopter
        
        var randomHeight = arc4random_uniform(190) + 100
        
        reverseHelicopter.scale = heliScale
        reverseHelicopter.position = CGPoint(x: -100, y: CGFloat(randomHeight))
        addChild(reverseHelicopter)
        
        reverseHelicopter.moveHelicopter(speed)
    }
    
    func updatedHeliScale() -> Float {
        var currentHelicopterScale: Float = 3.0
        
        if Enemy.score > 10 && Enemy.score < 20 {
            currentHelicopterScale = 2.5
        } else if Enemy.score > 20 && Enemy.score < 30 {
            currentHelicopterScale = 2.0
        } else if Enemy.score > 30 && Enemy.score < 40 {
            currentHelicopterScale = 1.5
        } else if Enemy.score > 40 && Enemy.score < 50 {
            currentHelicopterScale = 1
        } else if Enemy.score > 60 && Enemy.score < 60 {
            currentHelicopterScale = 0.5
        }
        
        return currentHelicopterScale
    }
    
    var speed: Double = 5
    func updatedHeliSpeed() -> Double {
        
        if Enemy.score > 10 {
            speed = 4.5
        } else if Enemy.score > 20 {
            speed = 4
        } else if Enemy.score > 125 {
            speed = 3.5
        } else if Enemy.score > 150 {
            speed = 3
        }
        return speed
    }
    
}