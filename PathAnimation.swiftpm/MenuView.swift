import SwiftUI

struct MenuView: View {
    @Binding var isOpen: Bool
    @Binding var currentPath: any PathProtocol
    private let maxWidth = UIScreen.main.bounds.width

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
                .opacity(isOpen ? 0.7 : 0)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isOpen.toggle()
                    }
                }
            ZStack {
                List {
                    Section {
                        Button {
                            currentPath = FlowerPath()
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isOpen = false
                            }
                        } label: {
                            HStack {
                                Image(systemName: "flower")
                                Text("Flower")
                            }
                        }
                        Button {
                            currentPath = StarPath()
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isOpen = false
                            }
                        } label: {
                            HStack {
                                Image(systemName: "star")
                                Text("Star")
                            }
                        }
                        Button {
                            currentPath = HelloPath()
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isOpen = false
                            }
                        } label: {
                            HStack {
                                Image(systemName: "hand.wave")
                                Text("Hello")
                            }
                        }
                        Button {
                            currentPath = WorldPath()
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isOpen = false
                            }
                        } label: {
                            HStack {
                                Image(systemName: "globe")
                                Text("World")
                            }
                        }
                    }
                }
                VStack {
                    Spacer()
                    Text("developed by")
                        .font(.footnote)
                    Text("akitorahayashi")
                        .font(.footnote)
                }
                .foregroundColor(.secondary)
                .padding()
            }
            .padding(.trailing, maxWidth/4)
            .offset(x: isOpen ? 0 : -maxWidth)
        }
    }
}
