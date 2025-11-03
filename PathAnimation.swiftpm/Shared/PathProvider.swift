import SwiftUI

enum PathProvider {
    static let allPaths: [any PathProtocol] = [
        FlowerPath(),
        StarPath(),
        HelloPath(),
        CirclePath(),
    ]

    static func icon(for path: any PathProtocol) -> String {
        switch path.name {
            case "Flower":
                "camera.macro"
            case "Star":
                "star"
            case "Hello":
                "hand.wave"
            case "Circle":
                "circle"
            default:
                "questionmark"
        }
    }
}
