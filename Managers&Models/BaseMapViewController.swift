//
//  BaseMapViewController.swift
//  Glenroe-Ballyorgan
//
//  Created by Liya Wang on 2024/9/28.
//

import Foundation
import UIKit
import MapboxMaps

class BaseMapViewController: UIViewController {
    private let sourceIdentifier = "route-source-identifier"
    private var mapView: MapView!
    private var routeLineSource: GeoJSONSource? // Must be var
    private var currentIndex = 0
    private var cancelable: Cancelable?

    override func viewDidLoad() {
        super.viewDidLoad()

        let centerCoordinate = getCenterCoordinate()
        let options = MapInitOptions(cameraOptions: CameraOptions(center: centerCoordinate, zoom: getZoomLevel()), styleURI: .light)

        mapView = MapView(frame: view.bounds, mapInitOptions: options)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)

        cancelable = mapView.mapboxMap.onEvery(event: .mapLoaded) { [weak self] _ in
            self?.addLine()
            self?.animatePolyline()
        }
    }

    func getCenterCoordinate() -> CLLocationCoordinate2D {
        fatalError("Must override in subclass")
    }

    func getZoomLevel() -> CGFloat {
        fatalError("Must override in subclass")
    }

    func getGeoJSONFileName() -> String {
        fatalError("Must override in subclass")
    }

    func addLine() {
        // Create the GeoJSON source with its id
        var geoJSONSource = GeoJSONSource(id: sourceIdentifier)
        geoJSONSource.data = GeoJSONSourceData.feature(Feature(geometry: LineString([])))
        self.routeLineSource = geoJSONSource

        // Add the source — no 'id' argument needed anymore
        try! mapView.mapboxMap.style.addSource(geoJSONSource)

        // Create the line layer with both id and source
        var lineLayer = LineLayer(id: "line-layer", source: sourceIdentifier)

        // Style the line
        lineLayer.lineColor = Value<StyleColor>.constant(StyleColor(UIColor.systemBlue))

        let lowZoomWidth: Double = 5.0
        let highZoomWidth: Double = 20.0
        lineLayer.lineWidth = Value<Double>.expression(
            Exp(.interpolate) {
                Exp(.linear)
                Exp(.zoom)
                14.0
                lowZoomWidth
                18.0
                highZoomWidth
            }
        )

        lineLayer.lineCap = Value<LineCap>.constant(.round)
        lineLayer.lineJoin = Value<LineJoin>.constant(.round)

        // Add the layer
        try! mapView.mapboxMap.style.addLayer(lineLayer)
    }


    func animatePolyline() {
        var currentCoordinates = [CLLocationCoordinate2D]()
        guard let geojsonURL = Bundle.main.url(forResource: getGeoJSONFileName(), withExtension: "geojson") else {
            print("Error: Failed to locate GeoJSON file in bundle.")
            return
        }
        guard let data = try? Data(contentsOf: geojsonURL) else {
            print("Error: Failed to load data from GeoJSON file.")
            return
        }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
              let jsonDict = jsonObject as? [String: Any],
              let features = jsonDict["features"] as? [[String: Any]] else {
            print("Error: Failed to parse GeoJSON file.")
            return
        }
        guard let geometry = features.first?["geometry"] as? [String: Any],
              let coordinates = geometry["coordinates"] as? [[Double]] else {
            print("Error: Failed to extract coordinates from GeoJSON.")
            return
        }

        let parsedCoordinates = coordinates.map { CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0]) }

        Timer.scheduledTimer(withTimeInterval: 0.10, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }

            guard !parsedCoordinates.isEmpty else {
                timer.invalidate()
                print("No coordinates found in GeoJSON.")
                return
            }

            if self.currentIndex >= parsedCoordinates.count {
                timer.invalidate()
                return
            }

            self.currentIndex += 1
            currentCoordinates = Array(parsedCoordinates[0..<self.currentIndex])
            let updatedLine = Feature(geometry: LineString(currentCoordinates))

            try! self.mapView.mapboxMap.style.updateGeoJSONSource(withId: self.sourceIdentifier, geoJSON: .feature(updatedLine))
        }
    }
}

