//
//  GameScene.swift
//  RwShooter
//
//  Created by Roman Dronov on 08.11.2020.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var player: SKNode?
    
    override func didMove(to view: SKView) {
        
        let playerNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 45, height: 45), cornerRadius: 10.0)
        
        playerNode.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        playerNode.fillColor = .black
        
        backgroundColor = .white
        
        player = playerNode
        addChild(player!)
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addMonster),
                SKAction.wait(forDuration: 1.0)
            ])
        ))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchesLocation = touch.location(in: self)
        
        let projectile = SKShapeNode(circleOfRadius: 10.0)
        projectile.position = player!.position
        
        let offset = touchesLocation - projectile.position
        
        if offset.x < 0 {
            return
        }
        
        projectile.fillColor = .red
        addChild(projectile)
        
        let direction = offset.normalized()
        let shootAmount = direction * 1000
        let realDest = shootAmount + projectile.position
        
        let actionMove = SKAction.move(to: realDest, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    private func addMonster() {
        let monster = SKShapeNode(rect: CGRect(x: 0, y: 0, width: self.monsterSpriteWidth, height: monsterSpriteHeight), cornerRadius: 10.0)
        let actualY = random(min: monsterSpriteHeight / 2.0, max: size.height - monsterSpriteHeight / 2.0)
        
        monster.position = CGPoint(x: size.width + monsterSpriteWidth / 2, y: actualY)
        monster.fillColor = .brown
        
        addChild(monster)
        
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        let actionMove = SKAction.move(to: CGPoint(x: -monsterSpriteWidth/2.0, y: actualY), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    private func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
    }
    
    private func random(min: CGFloat, max: CGFloat) -> CGFloat {
      return random() * (max - min) + min
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    private let monsterSpriteHeight = CGFloat(50)
    private let monsterSpriteWidth = CGFloat(50)
}
