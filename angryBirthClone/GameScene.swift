//
//  GameScene.swift
//  angryBirthClone
//
//  Created by Doğukan Doğan on 29.07.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bird = SKSpriteNode()
    var background = SKSpriteNode()
    var tree = SKSpriteNode()
    var birck1 = SKSpriteNode()
    var birck2 = SKSpriteNode()
    var birck3 = SKSpriteNode()
    var birck4 = SKSpriteNode()
    var birck5 = SKSpriteNode()
    var gameStart = false
    var originalPositon : CGPoint?
    var score = 0
    var scoreLabel = SKLabelNode()
    
    enum ColliderType: UInt32{
        case Bird = 1
        case Box = 2
    }
    
    override func didMove(to view: SKView) {
        
        background.texture = SKTexture(imageNamed: "background")
        background.position = CGPoint(x: 0, y: 0)
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        self.addChild(background)
        
        tree.texture = SKTexture(imageNamed: "tree")
        tree.position = CGPoint(x: self.frame.width * -0.3, y: self.frame.height * -0.14)
        tree.size = CGSize(width: self.frame.width * 0.2, height: self.frame.height * 0.5)
        bird.zPosition = 0
        self.addChild(tree)
        
        let birdTexture = SKTexture(imageNamed: "bird")
        bird.texture = birdTexture
        bird.position = CGPoint(x: self.frame.width * -0.32, y: self.frame.height * -0.09)
        originalPositon = bird.position
        bird.size = CGSize(width: self.frame.width * 0.07, height: self.frame.height * 0.13)
        bird.zPosition = 1
        let sizeBird = CGSize(width: self.frame.width * 0.07, height: self.frame.height * 0.13)
        bird.physicsBody = SKPhysicsBody(rectangleOf: sizeBird)
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.allowsRotation = false
        bird.physicsBody?.mass = 0.15
        bird.physicsBody?.collisionBitMask = ColliderType.Box.rawValue
        self.addChild(bird)
        
        birck1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        birck2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        birck3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        birck4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        birck5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        let birckTextTure = SKTexture(imageNamed: "birck")
        let size = CGSize(width: self.frame.width * 0.08, height: self.frame.height * 0.08)
        birck1.texture = birckTextTure
        birck1.position = CGPoint(x: self.frame.width * 0.2, y: self.frame.height * -0.351)
        birck1.size = CGSize(width: self.frame.width * 0.08, height: self.frame.height * 0.08)
        birck1.zPosition = 1
        birck1.physicsBody = SKPhysicsBody(rectangleOf: size)
        birck1.physicsBody?.affectedByGravity = true
        birck1.physicsBody?.isDynamic = true
        birck1.physicsBody?.allowsRotation = true
        birck1.physicsBody?.mass = 0.4
        self.addChild(birck1)
        
        birck2.texture = birckTextTure
        birck2.position = CGPoint(x: self.frame.width * 0.22, y: self.frame.height * -0.27)
        birck2.size = CGSize(width: self.frame.width * 0.08, height: self.frame.height * 0.08)
        birck2.zPosition = 1
        birck2.physicsBody = SKPhysicsBody(rectangleOf: size)
        birck2.physicsBody?.affectedByGravity = true
        birck2.physicsBody?.isDynamic = true
        birck2.physicsBody?.allowsRotation = true
        birck2.physicsBody?.mass = 0.4
        self.addChild(birck2)
        
        birck3.texture = birckTextTure
        birck3.position = CGPoint(x: self.frame.width * 0.28, y: self.frame.height * -0.19)
        birck3.size = CGSize(width: self.frame.width * 0.08, height: self.frame.height * 0.08)
        birck3.zPosition = 1
        birck3.physicsBody = SKPhysicsBody(rectangleOf: size)
        birck3.physicsBody?.affectedByGravity = true
        birck3.physicsBody?.isDynamic = true
        birck3.physicsBody?.allowsRotation = true
        birck3.physicsBody?.mass = 0.4
        self.addChild(birck3)
        
        birck4.texture = birckTextTure
        birck4.position = CGPoint(x: self.frame.width * 0.33, y: self.frame.height * -0.27)
        birck4.size = CGSize(width: self.frame.width * 0.08, height: self.frame.height * 0.08)
        birck4.zPosition = 1
        birck4.physicsBody = SKPhysicsBody(rectangleOf: size)
        birck4.physicsBody?.affectedByGravity = true
        birck4.physicsBody?.isDynamic = true
        birck4.physicsBody?.allowsRotation = true
        birck4.physicsBody?.mass = 0.4
        self.addChild(birck4)
        
        birck5.texture = birckTextTure
        birck5.position = CGPoint(x: self.frame.width * 0.36, y: self.frame.height * -0.351)
        birck5.size = CGSize(width: self.frame.width * 0.08, height: self.frame.height * 0.08)
        birck5.zPosition = 1
        birck5.physicsBody = SKPhysicsBody(rectangleOf: size)
        birck5.physicsBody?.affectedByGravity = true
        birck5.physicsBody?.isDynamic = true
        birck5.physicsBody?.allowsRotation = true
        birck5.physicsBody?.mass = 0.4
        self.addChild(birck5)
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.fontColor = UIColor.black
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height * 0.4)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        scene?.scaleMode = .fill
        physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue{
            
            score += 1
            scoreLabel.text = String(score)
            
        }
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStart == false{
            
            if let touch = touches.first{
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false{
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode{
                            
                            if sprite == bird{
                                
                                bird.position = touchLocation
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStart == false{
            
            if let touch = touches.first{
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false{
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode{
                            
                            if sprite == bird{
                                
                                bird.position = touchLocation
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStart == false{
            
            if let touch = touches.first{
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false{
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode{
                            
                            if sprite == bird{
                                
                                let dx = -(touchLocation.x - originalPositon!.x)
                                let dy = -(touchLocation.y - originalPositon!.y)
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                
                                gameStart = true
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if let birdPhy = bird.physicsBody{
            
            if birdPhy.velocity.dx <= 0.1 && birdPhy.velocity.dy <= 0.1 && birdPhy.angularVelocity <= 0.1 && gameStart == true{
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zPosition = 1
                bird.position = originalPositon!
                gameStart = false
                
            }
            
        }
        
    }
}
