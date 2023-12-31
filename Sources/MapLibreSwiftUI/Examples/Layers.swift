import CoreLocation
import MapLibre
import MapLibreSwiftDSL
import SwiftUI

struct Layer_Previews: PreviewProvider {
    static var previews: some View {
        let demoTilesURL = URL(string: "https://demotiles.maplibre.org/style.json")!

        // A collection of points with various
        // attributes
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

        MapView(styleURL: demoTilesURL) {
            // Silly example: a background layer on top of everything to create a tint effect
            BackgroundLayer(identifier: "rose-colored-glasses")
                .backgroundColor(constant: .systemPink.withAlphaComponent(0.3))
                .renderAboveOthers()
        }
            .ignoresSafeArea(.all)
            .previewDisplayName("Rose Tint")

        MapView(styleURL: demoTilesURL) {
            // Simple symbol layer demonstration with an icon
            SymbolStyleLayer(identifier: "simple-symbols", source: pointSource)
                .iconImage(constant: UIImage(systemName: "mappin")!)
        }
            .ignoresSafeArea(.all)
            .previewDisplayName("Simple Symbol")

        MapView(styleURL: demoTilesURL) {
            // Simple symbol layer demonstration with an icon
            SymbolStyleLayer(identifier: "rotated-symbols", source: pointSource)
                .iconImage(constant: UIImage(systemName: "location.north.circle.fill")!)
                .iconRotation(constant: 45)
        }
            .ignoresSafeArea(.all)
            .previewDisplayName("Rotated Symbols (Const)")

        MapView(styleURL: demoTilesURL) {
            // Simple symbol layer demonstration with an icon
            SymbolStyleLayer(identifier: "rotated-symbols", source: pointSource)
                .iconImage(constant: UIImage(systemName: "location.north.circle.fill")!)
                .iconRotation(featurePropertyNamed: "heading")
        }
            .ignoresSafeArea(.all)
            .previewDisplayName("Rotated Symbols (Dynamic)")

        // FIXME: This appears to be broken upstream; waiting for a new release
//        MapView(styleURL: demoTilesURL) {
//            // Simple symbol layer demonstration with an icon
//            SymbolStyleLayer(identifier: "simple-symbols", source: pointSource)
//                .iconImage(attribute: "icon",
//                           mappings: [
//                            "missing": UIImage(systemName: "mappin.slash")!,
//                            "club": UIImage(systemName: "figure.dance")!
//                           ],
//                           default: UIImage(systemName: "mappin")!)
//        }
//            .edgesIgnoringSafeArea(.all)
//            .previewDisplayName("Multiple Symbol Icons")
    }
}
