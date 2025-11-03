import SwiftUI

protocol PathProvider: Shape {
    var name: String { get }
    var animationConfig: AnimationConfig { get }
    var designConfig: DesignConfig { get }
}
