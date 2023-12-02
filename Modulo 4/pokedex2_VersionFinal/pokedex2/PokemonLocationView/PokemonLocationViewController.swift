//
//  PokemonLocationViewController.swift
//  pokedex2
//
//  Created by Alejandro Mendoza on 18/11/23.
//

import UIKit
import MapKit
import CoreLocation

class PokemonLocationViewController: UIViewController {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.preferredConfiguration = MKHybridMapConfiguration()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        
        return mapView
    }()
    
    private lazy var dismissButton: UIButton = {
        var dismissButtonConfiguration = UIButton.Configuration.filled()
        dismissButtonConfiguration.buttonSize = .medium
        dismissButtonConfiguration.baseForegroundColor = .secondaryLabel
        dismissButtonConfiguration.baseBackgroundColor = .secondarySystemBackground
        dismissButtonConfiguration.image = UIImage(systemName: "xmark.circle")
        dismissButtonConfiguration.cornerStyle = .capsule
        
        let dismissButton = UIButton(configuration: dismissButtonConfiguration)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        
        return dismissButton
    }()
    
    private lazy var showPokemonLocationButton: UIButton = {
        var pokemonLocationButtonConfiguration = UIButton.Configuration.filled()
        pokemonLocationButtonConfiguration.title = "show pokemon location"
        
        let pokemonLocationButton = UIButton(configuration: pokemonLocationButtonConfiguration)
        pokemonLocationButton.translatesAutoresizingMaskIntoConstraints = false
        pokemonLocationButton.addTarget(self, action: #selector(didTapShowLocationButton), for: .touchUpInside)
        
        return pokemonLocationButton
    }()
    
    private lazy var showDirectionsButton: UIButton = {
        var showDirectionsButtonConfiguration = UIButton.Configuration.filled()
        showDirectionsButtonConfiguration.title = "Show directions"
        
        let showDiretionsButton = UIButton(configuration: showDirectionsButtonConfiguration)
        showDiretionsButton.translatesAutoresizingMaskIntoConstraints = false
        showDiretionsButton.addTarget(self, action: #selector(didTapShowDirectionsButton), for: .touchUpInside)
        return showDiretionsButton
    }()
    
    let viewModel: PokemonLocationViewModel
    
    init(pokemon: Pokemon) {
        viewModel = PokemonLocationViewModel(pokemon: pokemon)
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
        mapView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        
        view.addSubview(mapView)
        view.addSubview(dismissButton)
        
        if let _ = viewModel.pokemonLatitude {
            let actionsStackView = UIStackView()
            actionsStackView.translatesAutoresizingMaskIntoConstraints = false
            actionsStackView.axis = .vertical
            actionsStackView.spacing = 8
            
            actionsStackView.addArrangedSubview(showPokemonLocationButton)
            actionsStackView.addArrangedSubview(showDirectionsButton)
            
            view.addSubview(actionsStackView)
            
            NSLayoutConstraint.activate([
                actionsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                actionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                actionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
        
    }
    
    @objc
    func dismissModal() {
        dismiss(animated: true)
    }
    
    @objc
    func didTapShowLocationButton() {
        viewModel.didTapShowPokemonLocationButton()
    }
    
    @objc
    func didTapShowDirectionsButton() {
        viewModel.didTapShowDirectionsButton()
    }
    

}

extension PokemonLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = .cyan
        render.lineWidth = 8.0
        return render
    }
}

extension PokemonLocationViewController: PokemonLocationViewModelDelegate {
    func showDirections(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) {
        let directionRequest = MKDirections.Request()
        
        directionRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: from))
        directionRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: to))
        
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { response, error in
            guard error == nil, let response, let route = response.routes.first else { return }
            
            self.mapView.addOverlay(route.polyline)
        }
    }
    
    func showPokemonLocation(with coordinate: CLLocationCoordinate2D) {
        let pokemonAnnotation = MKPointAnnotation()
        pokemonAnnotation.coordinate = coordinate
            
        mapView.addAnnotation(pokemonAnnotation)
        
        let mapRegion = MKCoordinateRegion(center: coordinate,
                                           span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                 longitudeDelta: 0.01))
        
        mapView.region = mapRegion
    }
    
    func updateUserLocation(with coordinate: CLLocationCoordinate2D) {
        let userLocationPin = MKPointAnnotation()
        userLocationPin.coordinate = coordinate
        
        mapView.addAnnotation(userLocationPin)
        
        let mapRegion = MKCoordinateRegion(center: coordinate,
                                           span: MKCoordinateSpan(latitudeDelta: 0.001,
                                                                  longitudeDelta: 0.001))
        mapView.region = mapRegion
    }
    
    func shouldShowNoPermissionAlert() {
        let alert = UIAlertController(title: "Location Permission",
                                      message: "Please update the location permission in Settings",
                                      preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            self?.dismissModal()
        }
        
        alert.addAction(dismissAction)
        
        present(alert, animated: true)
    }
}

