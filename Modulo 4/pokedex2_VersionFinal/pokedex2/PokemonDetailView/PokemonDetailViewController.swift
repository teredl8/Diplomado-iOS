//
//  PokemonDetailViewController.swift
//  pokedex2
//
//  Created by Alejandro Mendoza on 17/11/23.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    let viewModel: PokemonDetailViewModel
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        imageView.image = UIImage(systemName: "dog")
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        return imageView
    }()
    
    private lazy var pokemonNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        
        label.text = viewModel.pokemonNumber
        
        return label
    }()
    
    private lazy var pokemonHeight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        
        label.text = viewModel.pokemonHeight
        
        return label
    }()
    
    private lazy var pokemonWeight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        
        label.text = viewModel.pokemonWeight
        
        return label
    }()
    
    private lazy var pokemonWeaknesses: [UILabel] = {
        return viewModel.pokemonWeaknesses.map { weakness in
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: .title1)
            label.adjustsFontForContentSizeCategory = true
            
            label.text = weakness
            
            return label
        }
    }()
    
    private lazy var pokemonLocationButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.title = viewModel.locationButtonTitle
        
        let pokemonLocationButton = UIButton(configuration: buttonConfiguration)
        pokemonLocationButton.addTarget(self, 
                                        action: #selector(pokemonLocationButtonPressed),
                                        for: .touchUpInside)
        return pokemonLocationButton
    }()
    
    init(pokemon: Pokemon) {
        viewModel = PokemonDetailViewModel(pokemon: pokemon)
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        title = viewModel.pokemonName
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        
        let contentViewHeightAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightAnchor.isActive = true
        contentViewHeightAnchor.priority = UILayoutPriority.required - 1
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor ),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
        ])
        
        
        let pokemonInfoStackView = UIStackView()
        pokemonInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        pokemonInfoStackView.axis = .vertical
        pokemonInfoStackView.spacing = 16
        pokemonInfoStackView.distribution = .fill
        
        pokemonInfoStackView.addArrangedSubview(pokemonImageView)
        pokemonInfoStackView.addArrangedSubview(pokemonNumberLabel)
        pokemonInfoStackView.addArrangedSubview(pokemonHeight)
        pokemonInfoStackView.addArrangedSubview(pokemonWeight)
        
        for weakness in pokemonWeaknesses {
            pokemonInfoStackView.addArrangedSubview(weakness)
        }
        
        pokemonInfoStackView.addArrangedSubview(pokemonLocationButton)
        
        contentView.addSubview(pokemonInfoStackView)
        
        NSLayoutConstraint.activate([
            pokemonInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonInfoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pokemonInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pokemonInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
    }
    
    @objc
    func pokemonLocationButtonPressed() {
        let pokemonLocationViewController = PokemonLocationViewController(pokemon: viewModel.pokemon)
        present(pokemonLocationViewController, animated: true)
    }
    


}

extension PokemonDetailViewController: PokemonDetailViewModelDelegate {
    func updatePokemonImage(to image: UIImage) {
        pokemonImageView.image = image
    }
}
