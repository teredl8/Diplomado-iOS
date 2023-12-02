//
//  PokemonLocationViewModel.swift
//  pokedex2
//
//  Created by Alejandro Mendoza on 18/11/23.
//

import Foundation
import CoreLocation

protocol PokemonLocationViewModelDelegate: AnyObject {
    func updateUserLocation(with coordinate: CLLocationCoordinate2D)
    func showPokemonLocation(with coordinate: CLLocationCoordinate2D)
    func showDirections(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D)
    func shouldShowNoPermissionAlert()
}

class PokemonLocationViewModel: NSObject {
    
    private let pokemon: Pokemon
    private var userLocation: CLLocationCoordinate2D?
    private let locationManager = CLLocationManager()
    
    weak var delegate: PokemonLocationViewModelDelegate?
    
    var pokemonLatitude: Double? { pokemon.location?.latitude }
    var pokemonLongitude: Double? { pokemon.location?.longitude }
    
     init(pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func didTapShowPokemonLocationButton() {
        guard let pokemonLatitude, let pokemonLongitude else { return }
        
        delegate?.showPokemonLocation(with: CLLocationCoordinate2D(latitude: pokemonLatitude,
                                                                   longitude: pokemonLongitude))
    }
    
    func didTapShowDirectionsButton() {
        guard let pokemonLatitude, let pokemonLongitude, let userLocation else { return }
        
        delegate?.showDirections(from: userLocation, to: CLLocationCoordinate2D(latitude: pokemonLatitude,
                                                                                longitude: pokemonLongitude))
        
    }
}

extension PokemonLocationViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .denied {
            delegate?.shouldShowNoPermissionAlert()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        
        self.userLocation = currentLocation.coordinate
    }
}
