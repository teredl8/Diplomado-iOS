//
//  CaptureScene.swift
//  pokedex2
//
//  Created by Alejandro Mendoza on 25/11/23.
//

import UIKit
import SpriteKit

class CaptureScene: SKScene {
    private var sceneSize: CGSize
    private var movingPokeball: SKNode?
    
    private var gameTimer: Timer?
    private let regularAnimals = ["cat", "dog", "lizard", "bird", "fish"]
    
    init(sceneSize: CGSize) {
        self.sceneSize = sceneSize
        super.init(size: sceneSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .systemBackground
        
//        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.gravity = .zero
        
        physicsWorld.contactDelegate = self
        
        let pokeballTexture = SKTexture(image: UIImage(systemName: "cricket.ball")!)
        let pokeball = SKSpriteNode(texture: pokeballTexture)
        pokeball.name = "pokeball"
        pokeball.size = CGSize(width: 50, height: 50)
        pokeball.physicsBody = SKPhysicsBody(texture: pokeballTexture, size: pokeball.size)
        pokeball.physicsBody?.restitution = 0.4
        
        pokeball.position = CGPoint(x: sceneSize.width/2, y: sceneSize.height/2)
        
        pokeball.physicsBody?.contactTestBitMask = pokeball.physicsBody!.collisionBitMask
        
        addChild(pokeball)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.1,
                                         target: self,
                                         selector: #selector(placeAnimal),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    @objc
    private func placeAnimal() {
        let animals = regularAnimals + ["sun.max.circle"]
        
        guard let animalName = animals.randomElement(),
              let animalImage = UIImage(systemName: animalName) else { return }
        
        let animalTexture = SKTexture(image: animalImage)
        let animalNode = SKSpriteNode(texture: animalTexture)
        
        animalNode.physicsBody = SKPhysicsBody(texture: animalTexture, size: animalNode.size)
        animalNode.physicsBody?.velocity = CGVector(dx: 0, dy: -300)
        animalNode.physicsBody?.angularVelocity = 5
        animalNode.physicsBody?.linearDamping = 0
        animalNode.physicsBody?.angularDamping = 0
        
        animalNode.name = animalName
        
        let sceneWidth = Int(sceneSize.width)
        animalNode.position = CGPoint(x: Int.random(in: 0...sceneWidth), y: Int(sceneSize.height))
        
        addChild(animalNode)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.y < 0 {
                node.removeFromParent()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        for node in nodes(at: location) {
            if node.name == "pokeball" {
                movingPokeball = node
                movingPokeball?.position = location
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        movingPokeball?.position = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        movingPokeball = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        movingPokeball = nil
    }
}

extension CaptureScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "pokeball" || contact.bodyB.node?.name == "pokeball" &&
           contact.bodyA.node?.name == "sun.max.circle" || contact.bodyB.node?.name == "sun.max.circle" {
            // captured pokemon
        }
    }
}
