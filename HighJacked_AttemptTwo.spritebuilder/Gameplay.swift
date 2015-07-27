//
//  Gameplay.swift
//  HighJacked_AttemptTwo
//
//  Created by Ikey Benzaken on 7/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation
import AudioToolbox
import AVFoundation


class Gameplay: CCScene, CCPhysicsCollisionDelegate {
    
    var audio = OALSimpleAudio.sharedInstance()
    weak var scoreLabel: CCLabelTTF!
    weak var gamePhysicsNode: CCPhysicsNode!
    var currentBlackHelicopter: BlackHelicopter!
    var currentReverseBlackHelicopter: ReverseBlackHelicopter!
    weak var lifeBar: CCSprite!
    var soundIsPlaying: Bool = false
    weak var playerScoreLabel: CCLabelTTF!
    weak var highScoreLabel: CCLabelTTF!
    let defaults = NSUserDefaults.standardUserDefaults()
    var helicopters: [Helicopter!] = []
    
    var score: Int = 0 {
        didSet {
            scoreLabel.string = "\(score)"
        }
    }
    
    
    static var life: Float = 400 {
        didSet{
            life = max(min(life, 400),0)
            
        }
    }
    
    
    
    func didLoadFromCCB() {
        gamePhysicsNode.collisionDelegate = self
        multipleTouchEnabled = true
    }
    
    override func update(delta: CCTime) {
        
        gameOver()
        
        
        playerScoreLabel.string = "Your Score: \(Enemy.score)"
        var currentHighscore = defaults.integerForKey("highScore")
        
        if Enemy.score > currentHighscore {
            defaults.setInteger(Enemy.score, forKey: "highScore")
        }
        
        highScoreLabel.string = "High Score: \(currentHighscore)"
        lifeBar.scaleX = Gameplay.life / Float(400)
        
        
        var randomSpawn = arc4random_uniform(1000)
        var randomBlackSpawn = arc4random_uniform(1000)
        var randomReverseSpawn = arc4random_uniform(1000)
        var randomReverseBlackSpawn = arc4random_uniform(1000)
        var randomCoinXposition = arc4random_uniform(500) + 20
        
        updateEverything()
        
        if !gameOver() {
            IsEnemyInHelicopter()
            
            if randomSpawn < updatedSpawnProbability {
                showHelicopters(updatedHeliScale, heliSpeed: updatedHeliSpeed)
            } else if randomReverseSpawn < updatedSpawnProbability {
                showReverseHelicopters(updatedHeliScale, heliSpeed: updatedHeliSpeed)
            }
            
            if randomBlackSpawn < updatedBlackSpawnProbability {
                showBlackHelicopters(updatedHeliScale, heliSpeed: updatedHeliSpeed)
            } else if randomReverseSpawn < updatedBlackSpawnProbability {
                showReverseBlackHelicopters(updatedHeliScale, heliSpeed: updatedHeliSpeed)
            }
            
            
            if randomBlackSpawn < updatedCoinSpawnProbability {
                var coinPosition = CGPoint(x: Double(randomCoinXposition), y: 650)
                coinAppear(coinPosition)
            }
        }
        
        
        
    }
    
    func showHelicopters(heliScale: Double, heliSpeed: Double) {
        
        var helicopter = CCBReader.load("Helicopters/Helicopter") as! Helicopter
        helicopter.enemy.delegate = self
        var randomHeight = arc4random_uniform(190) + 100
        
        helicopter.scale = Float(heliScale)
        helicopter.position = CGPoint(x: CGFloat(700), y: CGFloat(randomHeight))
        helicopters.append(helicopter)
        addChild(helicopter)
        
        
        
        helicopter.moveHelicopter(heliSpeed)
        
    }
    
    func showReverseHelicopters(heliScale: Double, heliSpeed: Double) {
        
        var reverseHelicopter = CCBReader.load("Helicopters/ReverseHelicopter") as! ReverseHelicopter
        var randomHeight = arc4random_uniform(190) + 100
        
        reverseHelicopter.scale = Float(heliScale)
        reverseHelicopter.position = CGPoint(x: -100, y: CGFloat(randomHeight))
        helicopters.append(reverseHelicopter)
        addChild(reverseHelicopter)
        
        reverseHelicopter.moveHelicopter(heliSpeed)
    }
    
    
    
    func showBlackHelicopters(heliScale: Double, heliSpeed: Double) {
        
        var blackHelicopter = CCBReader.load("Helicopters/BlackHelicopter") as! BlackHelicopter
        var randomHeight = arc4random_uniform(190) + 100
        
        currentBlackHelicopter = blackHelicopter
        
        blackHelicopter.scale = Float(heliScale)
        blackHelicopter.position = CGPoint(x: 600, y: CGFloat(randomHeight))
        helicopters.append(blackHelicopter)
        gamePhysicsNode.addChild(blackHelicopter)
        
        blackHelicopter.moveHelicopter(heliSpeed)
    }
    
    func showReverseBlackHelicopters(heliScale: Double, heliSpeed: Double) {
        
        var reverseBlackHelicopter = CCBReader.load("Helicopters/ReverseBlackHelicopter") as! ReverseBlackHelicopter
        var randomHeight = arc4random_uniform(190) + 100
        currentReverseBlackHelicopter = reverseBlackHelicopter
        
        reverseBlackHelicopter.scale = Float(heliScale)
        reverseBlackHelicopter.position = CGPoint(x: -100, y: CGFloat(randomHeight))
        helicopters.append(reverseBlackHelicopter)
        gamePhysicsNode.addChild(reverseBlackHelicopter)
        
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
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, gunActivator: CCNode!, blackHelicopter: Helicopter!) -> Bool {
        if  blackHelicopter.enemy != nil {
            blackHelicopter.enemy.isShooting = true
            blackHelicopter.enemy.animationManager.runAnimationsForSequenceNamed("Shooting")
            //     vibrateAndShoot(blackHelicopter)
            audio.playEffect("Shooting.mp3")
            
        }
        return true
    }
    
    //    func vibrateAndShoot(currentHelicopter: Helicopter!) {
    //                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
    //                if currentHelicopter.enemy.wasKilled == false {
    //                    while currentHelicopter.enemy.isShooting {
    //                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    //                        Gameplay.life -= 0.02
    //                    }
    //                }
    //            }
    //    }
    
    
    
    
    
    
    var updatedHeliSpeed: Double!
    var updatedHeliScale: Double!
    var updatedSpawnProbability: UInt32!
    var updatedCoinSpawnProbability: UInt32!
    var updatedBlackSpawnProbability: UInt32!
    
    func updateEverything() {
        if Enemy.score < 20 {
            
            updatedHeliSpeed = 5
            updatedHeliScale = 3.0
            updatedSpawnProbability = 6
            updatedCoinSpawnProbability = 1
            updatedBlackSpawnProbability = 0
            
        } else if Enemy.score >= 20 && Enemy.score < 100 {
            
            updatedHeliSpeed = 4.5
            updatedHeliScale = 2.3
            updatedSpawnProbability = 6
            updatedCoinSpawnProbability = 1
            updatedBlackSpawnProbability = 0
            
        } else if Enemy.score >= 100 && Enemy.score < 150 {
            
            updatedHeliSpeed = 4.3
            updatedHeliScale = 2.0
            updatedSpawnProbability = 6
            updatedCoinSpawnProbability = 2
            updatedBlackSpawnProbability = 1
            
        } else if Enemy.score >= 150 && Enemy.score < 200 {
            
            updatedHeliSpeed = 4.15
            updatedHeliScale = 2.0
            updatedSpawnProbability = 4
            updatedCoinSpawnProbability = 2
            updatedBlackSpawnProbability = 2
            
            
        } else if Enemy.score >= 200 && Enemy.score < 300 {
            
            updatedHeliSpeed = 4.0
            updatedHeliScale = 2.0
            updatedSpawnProbability = 3
            updatedCoinSpawnProbability = 3
            updatedBlackSpawnProbability = 3
            
        } else if Enemy.score >= 300 && Enemy.score < 450 {
            
            updatedHeliSpeed = 3.5
            updatedHeliScale = 1.7
            updatedSpawnProbability = 2
            updatedCoinSpawnProbability = 4
            updatedBlackSpawnProbability = 7
            
        } else if Enemy.score >= 450 {
            
            updatedHeliSpeed = 3.0
            updatedHeliScale = 1.5
            updatedSpawnProbability = 0
            updatedCoinSpawnProbability = 5
            updatedBlackSpawnProbability = 11
            
        }
    }
    
    func IsEnemyInHelicopter() {
        for helicopter in helicopters {
            if helicopter.alreadyMoved  {
                println(helicopter.children.count)
                if helicopter.children.count > 1 {
                    helicopter.removeFromParent()
                    helicopters.removeAtIndex(helicopters.count - 1)
                    Gameplay.life -= Float(100)
                } else {
                    helicopter.removeFromParent()
                    helicopters.removeAtIndex(helicopters.count - 1)
                }
            }
        }
    }
    
    func gameOver() -> Bool {
        
        if Gameplay.life <= 0 {
            for helicopter in helicopters {
                helicopter.removeFromParent()
            }
            helicopters = []
            stopAllActions()
            animationManager.runAnimationsForSequenceNamed("Game Over Label")
            return true
        }
        return false
    }
    
    
}


extension Gameplay: EnemyDelegate{
    func enemyKilled(score: Int) {
        self.score += score
    }
}

