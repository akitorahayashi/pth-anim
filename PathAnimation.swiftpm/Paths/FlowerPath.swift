import SwiftUI

struct FlowerPath: Shape, PathProtocol {
    var name: String { "Flower" }

    var animationConfig: AnimationConfig {
        AnimationConfig(
            duration: 3.0,
            delay: 1.5,
            colors: [.pink, .purple, .orange]
        )
    }

    var designConfig: DesignConfig {
        DesignConfig(lineWidth: 4.0)
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let petalCount = 8
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * 0.3
        let angle = .pi * 2 / Double(petalCount)

        for i in 0 ..< petalCount {
            let startAngle = Double(i) * angle
            let endAngle = startAngle + angle * 0.8

            let petalPath = Path { petal in
                let controlRadius = outerRadius * 0.7
                let startPoint = CGPoint(
                    x: center.x + innerRadius * cos(startAngle),
                    y: center.y + innerRadius * sin(startAngle)
                )
                let endPoint = CGPoint(
                    x: center.x + innerRadius * cos(endAngle),
                    y: center.y + innerRadius * sin(endAngle)
                )
                let control1 = CGPoint(
                    x: center.x + controlRadius * cos(startAngle + angle * 0.25),
                    y: center.y + controlRadius * sin(startAngle + angle * 0.25)
                )
                let control2 = CGPoint(
                    x: center.x + controlRadius * cos(endAngle - angle * 0.25),
                    y: center.y + controlRadius * sin(endAngle - angle * 0.25)
                )

                petal.move(to: startPoint)
                petal.addCurve(to: endPoint, control1: control1, control2: control2)
                petal.addLine(to: center)
                petal.closeSubpath()
            }
            path.addPath(petalPath)
        }

        return path
    }
}
