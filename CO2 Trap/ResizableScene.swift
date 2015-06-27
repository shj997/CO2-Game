//
//  ResizableScene.swift
//  CO2 Trap
//
//  Created by Molly on 5/18/15.
//  Copyright (c) 2015 Molly. All rights reserved.
//

import SpriteKit


class ResizableScene: SKScene {
    
    let backgroundNodeName = "background"
    
    override func didChangeSize(oldSize: CGSize) {
    let newSize = size
    if newSize != oldSize {
    
        
    if let background = childNodeWithName(backgroundNodeName) as? SKSpriteNode {
   
    background.position = CGPointZero
    background.size = newSize
    }
        
        
    let transform = CGAffineTransformMakeScale(newSize.width/oldSize.width,
    newSize.height/oldSize.height)
        
    enumerateChildNodesWithName("*") { (node,stop) in
    node.position = CGPointApplyAffineTransform(node.position, transform)
    } }
    } }