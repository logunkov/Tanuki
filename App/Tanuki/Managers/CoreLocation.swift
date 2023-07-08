//
//  CoreLocation.swift
//  Tanuki
//
//  Created by Constantin on 04.07.2023.
//

import CoreLocation

// Текущая локация и время.
final class CurrentLocation {

	// MARK: - Internal methods

	// Получения текущего города.
	func currentCity() -> String {
		var resultCity = L10n.Location.city
		let locationManager = CLLocationManager()

		if let currentLocation = locationManager.location {
			let geocoder = CLGeocoder()
			geocoder.reverseGeocodeLocation(currentLocation) { placemarks, _ in
				if let placemark = placemarks?.first {
					if let city = placemark.locality {
						resultCity = city
					}
				}
			}
		}
		return resultCity
	}

	// Получения текущей даты.
	func currentDate() -> String {
		let currentDate = Date()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = L10n.Location.date

		return dateFormatter.string(from: currentDate)
	}
}
