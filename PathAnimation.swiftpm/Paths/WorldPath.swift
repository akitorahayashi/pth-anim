import SwiftUI

struct WorldPath: Shape, PathProtocol {
    var name: String { "World" }

    var animationConfig: AnimationConfig {
        AnimationConfig(
            duration: 6.0,
            delay: 2.5,
            colors: [.blue, .cyan]
        )
    }

    var designConfig: DesignConfig {
        DesignConfig(lineWidth: 5.0)
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 4
        path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        return path
    }
}
