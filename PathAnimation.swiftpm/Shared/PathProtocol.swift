import SwiftUI

protocol PathProtocol: Shape {
    var name: String { get }
    var animationConfig: AnimationConfig { get }
    var designConfig: DesignConfig { get }
}
