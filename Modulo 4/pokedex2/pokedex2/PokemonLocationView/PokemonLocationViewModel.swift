//
//  PokemonLocationViewModel.swift
//  pokedex2
//
//  Created by Diplomado on 18/11/23.
//

import Foundation
import CoreLocation

protocol PokemonLocationViewModelDelegate: AnyObject {
    func updateUserLocation(with coordinate: CLLocationCoordinate2D)
}

class PokemonLocationViewModel: NSObject {
    
    private var userLocation: CLLocationCoordinate2D? {
        willSet {
            if let newValue {
                delegate?.updateUserLocation(with: newValue)
            }
        }
    }
    
    private let locationManager = CLLocationManager()
    
    weak var delegate: PokemonLocationViewModelDelegate?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //Se pide que la ubicación sea lo más excata posible
        locationManager.requestWhenInUseAuthorization() // Pedir permiso al usuario
        locationManager.startUpdatingLocation()
    }
}

extension PokemonLocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        
        self.userLocation = currentLocation.coordinate
    }
}


