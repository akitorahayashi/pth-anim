import SwiftUI

struct StarPath: Shape, PathProtocol {
    var name: String { "Star" }

    var animationConfig: AnimationConfig {
        AnimationConfig(
            duration: 3.5,
            delay: 1.0,
            colors: [.yellow, .orange]
        )
    }

    var designConfig: DesignConfig {
        DesignConfig(lineWidth: 3.0)
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let innerRadius = radius * 0.4
        let points = 5
        let angle = .pi * 2 / Double(points)

        for i in 0 ..< points {
            let outerAngle = Double(i) * angle - .pi / 2
            let innerAngle = outerAngle + angle / 2

            let outerPoint = CGPoint(
                x: center.x + radius * cos(outerAngle),
                y: center.y + radius * sin(outerAngle)
            )
            let innerPoint = CGPoint(
                x: center.x + innerRadius * cos(innerAngle),
                y: center.y + innerRadius * sin(innerAngle)
            )

            if i == 0 {
                path.move(to: outerPoint)
            } else {
                path.addLine(to: outerPoint)
            }
            path.addLine(to: innerPoint)
        }
        path.closeSubpath()
        return path
    }
}
