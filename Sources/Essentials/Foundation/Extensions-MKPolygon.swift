//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

#if canImport(MKMapKit)
import MKMapKit

public extension MKPolygon {

    func contains(coordinate: CLLocationCoordinate2D) -> Bool {
        let polygonRenderer  = MKPolygonRenderer(polygon: self)
        let currentMapPoint  = MKMapPoint(coordinate)
        let polygonViewPoint = polygonRenderer.point(for: currentMapPoint)
        return  polygonRenderer.path.contains(polygonViewPoint)
    }

}

#endif
