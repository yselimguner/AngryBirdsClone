//
//  GameScene.swift
//  Angry Birds Clone
//
//  Created by Yavuz Güner on 13.07.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //Manuel kuş eklemek.
    //var bird2 = SKSpriteNode()
    
    var bird = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    
    //germe işlemleri için yazıyoruz.
    var gameStarted = false
    
    var originalPosition : CGPoint?
    
    //Çarpışma için yazıyoruz.
    enum ColliderType : UInt32 {
        //vereceğimiz rakamlar toplama yapıldığı zaman birbirine ulaşmaması lazım.
        case Bird = 1
        case Box = 2
        case Ground = 4
        case Tree = 8
    }
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
       
        /*
        let texture = SKTexture(imageNamed: "bird2")
        bird2 = SKSpriteNode(texture: texture)
        bird2.position = CGPoint(x: 0, y: 0)
        bird2.size = CGSize(width: self.frame.width / 15 , height: self.frame.height / 10)
        bird2.zPosition = 1
        self.addChild(bird2)
        */
        
        //Etrafına dikdörtgen gibi kapatıyor.
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        self.physicsWorld.contactDelegate = self
        
        //Bird
        
        bird = childNode(withName: "bird") as! SKSpriteNode
        
        let birdTexture = SKTexture(imageNamed: "bird1")
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height/13)
        bird.physicsBody?.affectedByGravity = false //ilk açıldığında havadan başlasın.
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.15
        
        originalPosition = bird.position
        
        
        //Çarpışma Algılaması için yazacağımız kodlar...
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Box.rawValue //Bird olursa eğer her kuşa çarptığında tepki verir.
        
        
        //Box
        
        let boxTexture = SKTexture(imageNamed: "brick")
        let size = CGSize(width: boxTexture.size().width / 6, height: boxTexture.size().height / 6)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: size) //dikdörtgene benzediğinden rectangle ile ilerlemek en iyisi.
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.allowsRotation = true //Kutuyu fırlattığımızda sağa sola dönsün istiyoruz.
        box1.physicsBody?.mass = 0.4
        
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue  //Çarpışmaları algılamak için yazarız.
        
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size) //dikdörtgene benzediğinden rectangle ile ilerlemek en iyisi.
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.allowsRotation = true //Kutuyu fırlattığımızda sağa sola dönsün istiyoruz.
        box2.physicsBody?.mass = 0.4
        
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size) //dikdörtgene benzediğinden rectangle ile ilerlemek en iyisi.
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.allowsRotation = true //Kutuyu fırlattığımızda sağa sola dönsün istiyoruz.
        box3.physicsBody?.mass = 0.4
        
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size) //dikdörtgene benzediğinden rectangle ile ilerlemek en iyisi.
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.allowsRotation = true //Kutuyu fırlattığımızda sağa sola dönsün istiyoruz.
        box4.physicsBody?.mass = 0.4
        
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue

        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size) //dikdörtgene benzediğinden rectangle ile ilerlemek en iyisi.
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.allowsRotation = true //Kutuyu fırlattığımızda sağa sola dönsün istiyoruz.
        box5.physicsBody?.mass = 0.4
        
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        
        //Label'ı oluştururz. Score'un yazıldığı
        
        scoreLabel.fontName = "Arial"
        scoreLabel.fontSize = 50
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            
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
       
        /* kuşu uçurmak için yapacağımız hareketlerii buraya yazarız.
        bird.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 200)) //Kuş eğer ağır geldiyse mass'i değiştir.
        bird.physicsBody?.affectedByGravity = true
         */
        
        //Kuşu taşıma işlemi...
        if gameStarted == false {
            
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation //bunları sadece burada yapmayız. Kopyalayıp touches moved'ın altına da yazarız.
                            }
                        }
                    }
                }
            }
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation //bunları sadece touchbeganda yapmayız. Kopyalayıp touches moved'ın altına da yazarız.
                            }
                        }
                    }
                }
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                
                                let dx = -(touchLocation.x - originalPosition!.x)
                                let dy = -(touchLocation.y - originalPosition!.y) //gideceği yön istikametinden ötürü
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                
                                gameStarted = true
                                
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
        //İşlemler bitince resetlemek...
        if let birdPhysicsBody = bird.physicsBody {
            
            if birdPhysicsBody.velocity.dx <= 0.1 && birdPhysicsBody.velocity.dy <= 0.1 && birdPhysicsBody.angularVelocity <= 0.1 && gameStarted == true {
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zPosition = 1
                bird.position = originalPosition!
                gameStarted = false
                
                score = 0
                scoreLabel.text = String(score)
                gameStarted = false
            }
        }
    }
}
