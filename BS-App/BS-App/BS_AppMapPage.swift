//
//  BS_AppMapPage.swift
//  BS-App
//
//  Created by Tom Knight on 22/03/2025.
//
import SwiftUI
import MapKit
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var heading: CLLocationDirection = 0 // Stores direction in degrees
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.userLocation = location.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        DispatchQueue.main.async {
            self.heading = newHeading.trueHeading // Get heading in degrees
        }
    }
}

struct BS_AppMapPage: View {
    @StateObject private var locationManager = LocationManager()
    @State private var position: MapCameraPosition = .automatic
    @State private var lastKnownLocation: CLLocationCoordinate2D?

    init() {
        MKMapView.appearance().overrideUserInterfaceStyle = .dark // Force dark mode
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Map(position: $position) {
                if let userLocation = locationManager.userLocation {
                    Annotation("", coordinate: userLocation) {
                        ArrowHead(rotation: locationManager.heading)
                    }
                }
            }
            .edgesIgnoringSafeArea(.all) // Extends to the very top
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onReceive(locationManager.$userLocation) { newLocation in
                if let newLocation = newLocation, shouldUpdateLocation(newLocation) {
                    position = .region(
                        MKCoordinateRegion(
                            center: newLocation,
                            span: MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005)
                        )
                    )
                    lastKnownLocation = newLocation
                }
            }
            
            ZStack {
                Rectangle()
                    .fill(Color(red: 54/255, green: 54/255, blue: 54/255))
                    .frame(height: 100)
                    .edgesIgnoringSafeArea(.bottom)
                
                Rectangle()
                    .fill(Color(red: 189/255, green: 80/255, blue: 255/255))
                    .frame(height: 2)
                    .padding(.bottom, 100)
                
                HStack(spacing: 4) {
                    MapPageBottomButton(imageName: "MainPageIconDeactivated")
                    Divider()
                    MapPageBottomButton(imageName: "MapPageIconActivated")
                    Divider().frame(width: 15)
                    MapPageBottomButton(imageName: "CameraPageIconDeactivated")
                    Divider().frame(width: 15)
                    MapPageBottomButton(imageName: "MessagingPageIconDeactivated")
                    Divider()
                    MapPageBottomButton(imageName: "SettingsPageIconDeactivated")
                }
                .frame(height: 50)
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 36/255, green: 36/255, blue: 36/255))
        .edgesIgnoringSafeArea(.all)
    }

    private func shouldUpdateLocation(_ newLocation: CLLocationCoordinate2D) -> Bool {
        guard let lastLocation = lastKnownLocation else { return true }
        return abs(lastLocation.latitude - newLocation.latitude) > 0.00001 ||
               abs(lastLocation.longitude - newLocation.longitude) > 0.00001
    }
}

struct ArrowHead: View {
    var rotation: Double

    var body: some View {
        IrregularArrow()
            .stroke(Color.black, lineWidth: 3) // Black outline
            .background(IrregularArrow().fill(Color(red: 189/255, green: 80/255, blue: 1.0))) // Fill color bd50ff
            .frame(width: 28, height: 28) // Slightly bigger for visibility
            .rotationEffect(.degrees(rotation))
    }
}

// Custom arrow shape with a cut-off back
struct IrregularArrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width * 0.5, y: 0))        // Top center (point)
        path.addLine(to: CGPoint(x: 0, y: height * 0.75))    // Bottom left
        path.addLine(to: CGPoint(x: width * 0.25, y: height)) // Slight cut-off
        path.addLine(to: CGPoint(x: width * 0.75, y: height)) // Slight cut-off
        path.addLine(to: CGPoint(x: width, y: height * 0.75)) // Bottom right
        path.closeSubpath()
        
        return path
    }
}

struct MapPageBottomButton: View {
    let imageName: String
    
    var body: some View {
        Button(action: {
            // Handle button action
        }) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 75)
                .padding(.horizontal, 4)
        }
    }
}

struct BS_AppMapPage_Previews: PreviewProvider {
    static var previews: some View {
        BS_AppMapPage()
    }
}
