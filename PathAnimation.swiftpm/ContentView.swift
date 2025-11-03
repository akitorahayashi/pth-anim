import SwiftUI

// Define the target aspect ratio here
private let targetAspectRatio: CGFloat = 16.0 / 9.0 // Example: 16:9. Adjust if needed.

//
struct ContentView: View {
    @State private var drawProgress: CGFloat = 0.0
    @State private var isAnimatingForward = true
    @State private var isAnimating = false
    @State private var currentPath: any PathProtocol = FlowerPath()

    var body: some View {
        GeometryReader { geometry in
            // Calculate fitting size using the helper method
            let fittingSize = calculateFittingSize(for: geometry)

            ZStack {
                AnyShape(currentPath)
                    .trim(from: 0.0, to: drawProgress)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: currentPath.animationConfig.colors),
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        style: StrokeStyle(lineWidth: currentPath.designConfig.lineWidth, lineCap: .round, lineJoin: .round)
                    )

                if !isAnimating {
                    Text("画面をタップしてください")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 50)
                        .transition(.opacity)
                }
            }
            .frame(width: fittingSize.width, height: fittingSize.height)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            let time = CFAbsoluteTimeGetCurrent()
            print("\(time): onTapGesture - Tap detected. isAnimating: \(isAnimating)")
            if !isAnimating {
                print("\(time): onTapGesture - Calling startAnimation.")
                startAnimation()
            }
        }
    }

    // アニメーションを開始する関数
    func startAnimation() {
        let startTime = CFAbsoluteTimeGetCurrent()
        guard !isAnimating else {
            print("\(startTime): startAnimation - Already animating, returning.")
            return
        }

        print(
            "\(startTime): startAnimation - Starting forward animation. Setting isAnimating=true, drawProgress=0.0."
        )
        withAnimation {
            isAnimating = true
        }
        isAnimatingForward = true
        drawProgress = 0.0

        withAnimation(.easeInOut(duration: currentPath.animationConfig.duration)) {
            print("\(startTime): startAnimation - Applying forward animation to 1.0.")
            drawProgress = 1.0
        }

        // Manually simulate completion for iOS versions prior to 17 by delaying for the duration
        DispatchQueue.main.asyncAfter(deadline: .now() + currentPath.animationConfig.duration) {
            let forwardEndTime = CFAbsoluteTimeGetCurrent()
            guard isAnimatingForward else {
                print(
                    "\(forwardEndTime): Forward animation completion called, but no longer animating forward. Ignoring."
                )
                return
            }
            print("\(forwardEndTime): Forward animation visually completed. Starting delay.")

            DispatchQueue.main.asyncAfter(deadline: .now() + currentPath.animationConfig.delay) {
                guard isAnimatingForward, isAnimating else {
                    print(
                        "\(CFAbsoluteTimeGetCurrent()): Delay finished, but animation state changed. Ignoring return trigger."
                    )
                    return
                }

                let delayEndTime = CFAbsoluteTimeGetCurrent()
                print("\(delayEndTime): Delay finished. Starting return animation.")

                isAnimatingForward = false

                withAnimation(.easeInOut(duration: currentPath.animationConfig.duration)) {
                    print("\(delayEndTime): Applying return animation to 0.0.")
                    drawProgress = 0.0
                }

                // Simulate completion of the return animation
                DispatchQueue.main.asyncAfter(deadline: .now() + currentPath.animationConfig.duration) {
                    guard !isAnimatingForward, isAnimating else {
                        print(
                            "\(CFAbsoluteTimeGetCurrent()): Return animation completion called, but state is unexpected. Ignoring reset."
                        )
                        return
                    }
                    let returnEndTime = CFAbsoluteTimeGetCurrent()
                    print("\(returnEndTime): Return animation visually completed. Animation cycle complete.")
                    isAnimatingForward = true
                    withAnimation {
                        isAnimating = false
                    }
                }
            }
        }
    }

    // Helper method to calculate fitting size based on aspect ratio
    private func calculateFittingSize(for geometry: GeometryProxy) -> CGSize {
        let availableWidth = geometry.size.width
        let availableHeight = geometry.size.height
        var fittingWidth: CGFloat
        var fittingHeight: CGFloat

        let heightBasedOnWidth = availableWidth / targetAspectRatio
        let widthBasedOnHeight = availableHeight * targetAspectRatio

        if heightBasedOnWidth <= availableHeight {
            fittingWidth = availableWidth
            fittingHeight = heightBasedOnWidth
        } else {
            fittingWidth = widthBasedOnHeight
            fittingHeight = availableHeight
        }
        return CGSize(width: fittingWidth, height: fittingHeight)
    }
}
