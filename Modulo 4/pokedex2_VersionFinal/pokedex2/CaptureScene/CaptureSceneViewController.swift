//
//  CaptureSceneViewController.swift
//  pokedex2
//
//  Created by Alejandro Mendoza on 25/11/23.
//

import UIKit
import SpriteKit

class CaptureSceneViewController: UIViewController {
    
    private lazy var gameSceneView: SKView = {
        let sceneView = SKView()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        
        return sceneView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let sceneSize = CGSize(width: view.bounds.width,
                               height: view.safeAreaLayoutGuide.layoutFrame.height)
        
        let gameScene = CaptureScene(sceneSize: sceneSize)
        gameScene.scaleMode = .aspectFill
        
        gameSceneView.presentScene(gameScene)
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(gameSceneView)
        
        NSLayoutConstraint.activate([
            gameSceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameSceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameSceneView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gameSceneView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
