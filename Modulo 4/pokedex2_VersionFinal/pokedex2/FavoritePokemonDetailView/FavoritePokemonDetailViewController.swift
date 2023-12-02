//
//  FavoritePokemonDetailViewController.swift
//  pokedex2
//
//  Created by Alejandro Mendoza on 25/11/23.
//

import UIKit
import PhotosUI
import Lottie

class FavoritePokemonDetailViewController: UIViewController {
    private lazy var pokemonImageView: UIImageView = {
        let pokemonImage = UIImage(systemName: "cat")
        let pokemonImageView = UIImageView(image: pokemonImage)
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return pokemonImageView
    }()
    
    private var currentAnimation: Int = 0
    
    let viewModel: FavoritePokemonDetailViewModel
    
    init(pokemon: Pokemon) {
        viewModel = FavoritePokemonDetailViewModel(pokemon: pokemon)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        let animationView = LottieAnimationView(name: "pokeball_animation")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        var animationButtonConfiguration = UIButton.Configuration.filled()
        animationButtonConfiguration.title = "Animate"
        
        let animationButton = UIButton(configuration: animationButtonConfiguration)
        animationButton.translatesAutoresizingMaskIntoConstraints = false
        animationButton.addTarget(self, action: #selector(didTapAnimateButton), for: .touchUpInside)
        
        var captureButtonConfiguration = UIButton.Configuration.tinted()
        captureButtonConfiguration.title = "Capture"
        
        let captureButton = UIButton(configuration: captureButtonConfiguration)
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        captureButton.addTarget(self, action: #selector(didTapCaptureButton), for: .touchUpInside)
        
        var selfieButtonConfiguration = UIButton.Configuration.plain()
        selfieButtonConfiguration.title = "Take selfie"
        
        let selfieButton = UIButton(configuration: selfieButtonConfiguration)
        selfieButton.translatesAutoresizingMaskIntoConstraints = false
        selfieButton.addTarget(self, action: #selector(didTapSelfieButton), for: .touchUpInside)
        
        let actionStackView = UIStackView()
        actionStackView.translatesAutoresizingMaskIntoConstraints = false
        actionStackView.axis = .vertical
        actionStackView.spacing = 8
        
        actionStackView.addArrangedSubview(animationButton)
        actionStackView.addArrangedSubview(captureButton)
        actionStackView.addArrangedSubview(selfieButton)
        
        view.addSubview(pokemonImageView)
        view.addSubview(actionStackView)
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            
            actionStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc
    private func didTapSelfieButton() {
        #if targetEnvironment(simulator)
        var photoPickerConfiguration = PHPickerConfiguration()
        photoPickerConfiguration.filter = .images
        photoPickerConfiguration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: photoPickerConfiguration)
        photoPicker.delegate = self
        
        present(photoPicker, animated: true)
        #else
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true)
        #endif
    }
    
    @objc
    private func didTapCaptureButton() {
        navigationController?.pushViewController(CaptureSceneViewController(), animated: true)
    }
    
    
    @objc
    private func didTapAnimateButton() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5) {
            switch self.currentAnimation {
            case 0:
                self.pokemonImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
            case 1:
                self.pokemonImageView.transform = CGAffineTransform.identity
            case 2:
                self.pokemonImageView.transform = CGAffineTransform(translationX: 0, y: 100)
            case 3:
                self.pokemonImageView.transform = .identity
            case 4:
                self.pokemonImageView.transform = CGAffineTransform(rotationAngle: .pi)
            case 5:
                self.pokemonImageView.transform = .identity
            case 6:
                self.pokemonImageView.backgroundColor = .purple
            case 7:
                self.pokemonImageView.backgroundColor = .clear
            default:
                break
            }
        } completion: { _ in
            self.currentAnimation += 1
            
            self.currentAnimation = self.currentAnimation > 7 ? 0 : self.currentAnimation
        }
        

    }
    

}

extension FavoritePokemonDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
        print(image.size)
    }
}

extension FavoritePokemonDetailViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let itemProvider = results.first?.itemProvider,
              itemProvider.canLoadObject(ofClass: UIImage.self)
        else { return }
        
        itemProvider.loadObject(ofClass: UIImage.self) { image, error in
            guard let image = image as? UIImage, error == nil else { return }
            
            print(image.size)
        }
    }
}
