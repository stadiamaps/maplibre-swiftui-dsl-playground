import CoreLocation
import MapLibre
import MapLibreSwiftDSL
import SwiftUI

// A collection of points with various
// attributes
@MainActor
let pointSource = ShapeSource(identifier: "points") {
    // Uses the DSL to quickly construct point features inline
    MLNPointFeature(coordinate: CLLocationCoordinate2D(latitude: 51.47778, longitude: -0.00139))

    MLNPointFeature(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0)) { feature in
        feature.attributes["icon"] = "missing"
        feature.attributes["heading"] = 45
    }

    MLNPointFeature(coordinate: CLLocationCoordinate2D(latitude: 39.02001, longitude: 1.482148)) { feature in
        feature.attributes["icon"] = "club"
        feature.attributes["heading"] = 145
    }
}

#Preview("Rose Tint") {
    MapView(styleURL: demoTilesURL) {
        // Silly example: a background layer on top of everything to create a tint effect
        BackgroundLayer(identifier: "rose-colored-glasses")
            .backgroundColor(.systemPink.withAlphaComponent(0.3))
            .renderAboveOthers()
    }
    .ignoresSafeArea(.all)
}

#Preview("Simple Symbol") {
    MapView(styleURL: demoTilesURL) {
        // Simple symbol layer demonstration with an icon
        SymbolStyleLayer(identifier: "simple-symbols", source: pointSource)
            .iconImage(UIImage(systemName: "mappin")!)
    }
    .ignoresSafeArea(.all)
}

#Preview("Rotated Symbols (Const)") {
    MapView(styleURL: demoTilesURL) {
        // Simple symbol layer demonstration with an icon
        SymbolStyleLayer(identifier: "rotated-symbols", source: pointSource)
            .iconImage(UIImage(systemName: "location.north.circle.fill")!)
            .iconRotation(45)
    }
    .ignoresSafeArea(.all)
}

#Preview("Rotated Symbols (Dynamic)") {
    MapView(styleURL: demoTilesURL) {
        // Simple symbol layer demonstration with an icon
        SymbolStyleLayer(identifier: "rotated-symbols", source: pointSource)
            .iconImage(UIImage(systemName: "location.north.circle.fill")!)
            .iconRotation(featurePropertyNamed: "heading")
    }
    .ignoresSafeArea(.all)
}

#Preview("Circles with Symbols") {
    MapView(styleURL: demoTilesURL) {
        // Simple symbol layer demonstration with an icon
        CircleStyleLayer(identifier: "simple-circles", source: pointSource)
            .radius(16)
            .color(.systemRed)
            .strokeWidth(2)
            .strokeColor(.white)

        SymbolStyleLayer(identifier: "simple-symbols", source: pointSource)
            .iconImage(UIImage(systemName: "mappin")!.withRenderingMode(.alwaysTemplate))
            .iconColor(.white)
    }
    .ignoresSafeArea(.all)
}

// TODO: Fixme
// #Preview("Multiple Symbol Icons") {
//    MapView(styleURL: demoTilesURL) {
//        // Simple symbol layer demonstration with an icon
//        SymbolStyleLayer(identifier: "simple-symbols", source: pointSource)
//            .iconImage(attribute: "icon",
//                       mappings: [
//                        "missing": UIImage(systemName: "mappin.slash")!,
//                        "club": UIImage(systemName: "figure.dance")!
//                       ],
//                       default: UIImage(systemName: "mappin")!)
//    }
//    .edgesIgnoringSafeArea(.all)
// }
