//
//  PokemonLocationViewController.swift
//  pokedex2
//
//  Created by Diplomado on 18/11/23.
//

import UIKit
import MapKit
import CoreLocation // Ubicación del dispoditivo

class PokemonLocationViewController: UIViewController {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.preferredConfiguration = MKHybridMapConfiguration() // Vista satelital
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    let viewModel: PokemonLocationViewModel
    
    init() {
        viewModel = PokemonLocationViewModel()
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
        self.view.backgroundColor = .systemBackground
        
        view.addSubview(mapView)
        view.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    
    @objc
    func dismissModal() {
        dismiss(animated: true)
    }
}

extension PokemonLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        
        let coordinate = currentLocation.coordinate
        
        let userLocationPin = MKPointAnnotation()
        userLocationPin.coordinate = coordinate
        
        mapView.addAnnotation(userLocationPin)
        
        let mapRegion = MKCoordinateRegion(center: coordinate, span:  MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
}


extension PokemonLocationViewController: PokemonLocationViewModelDelegate {
    func updateUserLocation(with coordinate: CLLocationCoordinate2D) {
        let userLocationPin = MKPointAnnotation()
        userLocationPin.coordinate = coordinate
        
        mapView.addAnnotation(userLocationPin)
        
        let mapRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
    }
}

// weak - ayuda al problema de detención de memoria 
