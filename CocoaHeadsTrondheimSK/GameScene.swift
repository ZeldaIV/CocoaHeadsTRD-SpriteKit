//
//  GameScene.swift
//  CocoaHeadsTrondheimSK
//
//  Created by Martin Hagerup on 13.05.15.
//  Copyright (c) 2015 Martin Hagerup. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var sprite = SKSpriteNode(imageNamed:"football2")
    var texture = SKTexture(imageNamed: "football2")
    //var particle : SKEmitterNode!
    var startPoint: CGPoint!
    var leftJumper: SKSpriteNode!
    var rightJumper: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        /*let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)*/

        //particle?.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        var particle = childNodeWithName("SmokeParticle") as? SKEmitterNode
        particle?.removeFromParent()
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        sprite.xScale = 0.1
        sprite.yScale = 0.1
        sprite.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        sprite.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.0, size: sprite.size)
        sprite.physicsBody?.dynamic = true
        sprite.physicsBody?.affectedByGravity = true
        sprite.physicsBody?.allowsRotation = true
        sprite.physicsBody?.density = 0.3
        sprite.physicsBody?.restitution = 0.7
        
        //self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        let spriteR = SKSpriteNode(imageNamed:"Rectangle")
        let textureR = SKTexture(imageNamed: "Rectangle")
        
        spriteR.xScale = 0.2
        spriteR.yScale = 0.2
        spriteR.position = CGPoint(x: CGRectGetMidX(self.frame)-40, y: CGRectGetMidY(self.frame)-150)
        
        spriteR.physicsBody = SKPhysicsBody(texture: textureR, alphaThreshold: 0.0, size: spriteR.size)
        spriteR.physicsBody?.dynamic = true
        spriteR.physicsBody?.affectedByGravity = false
        spriteR.physicsBody?.pinned = true
        spriteR.physicsBody?.allowsRotation = true
        
        rightJumper = childNodeWithName("rightJ") as? SKSpriteNode
        rightJumper.position = CGPoint(x: CGRectGetMaxX(self.frame), y: CGRectGetMinY(self.frame)+20)
        let topBox = childNodeWithName("topBox") as! SKSpriteNode
        topBox.position = CGPoint(x: CGRectGetMaxX(self.frame)+200, y: rightJumper.position.y+90)
        let bottomBox = childNodeWithName("bottomBox") as! SKSpriteNode
        bottomBox.position = CGPoint(x: CGRectGetMaxX(self.frame)+200, y: rightJumper.position.y-100)
        
        leftJumper = childNodeWithName("leftJ") as? SKSpriteNode
        leftJumper.position = CGPoint(x: CGRectGetMinX(self.frame), y: CGRectGetMinY(self.frame)+20)
        let topBoxL = childNodeWithName("topBoxL") as! SKSpriteNode
        topBoxL.position = CGPoint(x: CGRectGetMinX(self.frame)-200, y: leftJumper.position.y+90)
        let bottomBoxL = childNodeWithName("bottomBoxL") as! SKSpriteNode
        bottomBoxL.position = CGPoint(x: CGRectGetMinX(self.frame)-200, y: leftJumper.position.y-100)
        //let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        
        //sprite.runAction(SKAction.repeatActionForever(action))

        self.addChild(sprite)
        sprite.addChild(particle!)
        particle?.position = CGPointMake(0, -170)
        self.addChild(spriteR)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            let node = nodeAtPoint(location)
            startPoint = node.position
            
            rightJumper.physicsBody?.applyImpulse(CGVectorMake(0, 1100))
            leftJumper.physicsBody?.applyImpulse(CGVectorMake(0, 1100))
            
        }
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let endPoint = touch.locationInNode(self)
            let dx = startPoint.x - endPoint.x
            let dy = startPoint.y - endPoint.y
            let nyVerdi = sqrt((dx*dx)+(dy*dy))
            
            //sprite.physicsBody?.applyForce(CGVectorMake((endPoint.x - startPoint.x)*15, nyVerdi*15))
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        let speed = sprite.physicsBody?.velocity
        if speed?.dy > 1000 {
            sprite.physicsBody?.velocity.dy = CGFloat(1000)
            //println("Speed: \(speed?.dx) \(speed?.dy)")
        }
        

    }
}
