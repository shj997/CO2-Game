//
//  GameScene.swift
//  CO2 Trap
//
//  Created by Molly on 5/18/15.
//  Copyright (c) 2015 Molly. All rights reserved.
//

import SpriteKit

func BoundsOfSprite( sprite: SKSpriteNode ) -> CGRect {
    var bounds = sprite.frame
    let anchor = sprite.anchorPoint
    bounds.origin.x = 0.0 - bounds.width*anchor.x
    bounds.origin.y = 0.0 - bounds.height*anchor.y
    return bounds
}

class GameScene: ResizableScene {
        
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
        
        // Fit the scene inside the new view
        scaleMode = .AspectFill
        size = view.frame.size
        
        
        //Add the computed physics boundries to the scene
        //
        
        let backgroundNode = childNodeWithName(backgroundNodeName) as? SKSpriteNode
        
        
        
        
        // If the interface is horizontally constrained (iPhone/iPod), make all of the play elements half sized
        let scale = CGFloat( view.traitCollection.horizontalSizeClass == .Compact ? 0.5 : 1.0 )
        enumerateChildNodesWithName("*") { (node,stop) in
            if node !== backgroundNode {
                node.xScale = scale
                node.yScale = scale
            }
        }

        
        
        if let background = backgroundNode {
            let body = SKPhysicsBody(edgeLoopFromRect: background.frame)
            physicsBody = body
        }
        
       
        
        if let beaker = childNodeWithName("beaker") as? SKSpriteNode {
            if beaker.physicsBody == nil {
            let bounds = BoundsOfSprite(beaker)
            let side = CGFloat(8.0)
            let base = CGFloat(6.0)
            let beakerEdgePath = CGPathCreateMutable()
            CGPathMoveToPoint(beakerEdgePath, nil, bounds.minX, bounds.minY)
            CGPathAddLineToPoint(beakerEdgePath, nil, bounds.minX, bounds.maxY)
            CGPathAddLineToPoint(beakerEdgePath, nil, bounds.minX+side, bounds.maxY)
            CGPathAddLineToPoint(beakerEdgePath, nil, bounds.minX+side, bounds.minY+base)
            CGPathAddLineToPoint(beakerEdgePath, nil, bounds.maxX-side, bounds.minY+base)
            CGPathAddLineToPoint(beakerEdgePath, nil, bounds.maxX-side, bounds.maxY)
            CGPathAddLineToPoint(beakerEdgePath, nil, bounds.maxX, bounds.maxY)
            CGPathAddLineToPoint(beakerEdgePath, nil, bounds.maxX, bounds.minY)
            let body = SKPhysicsBody(edgeLoopFromPath: beakerEdgePath)
            beaker.physicsBody = body
            }
        }
        

        
        
        enumerateChildNodesWithName("CO2") { (node,stop) in
            func randomForce( # min: CGFloat, # max: CGFloat ) -> CGFloat {
            return CGFloat(arc4random()) * (max-min) / CGFloat(UInt32.max) + min
            }
            if let body = node.physicsBody {
            body.applyForce(CGVector(dx: randomForce(min: -100.0, max: 100.0),
            dy: randomForce(min: -100.0, max: 100.0)))
            body.applyAngularImpulse(randomForce(min: -0.01, max: 0.01))
            } }
        view.ignoresSiblingOrder = true
        
        

        size = view.frame.size
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Capture the CO2!";
        myLabel.fontSize = 30;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
        
        
    }}
      