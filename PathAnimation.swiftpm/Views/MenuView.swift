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
                        ForEach(PathProvider.allPaths.indices, id: \.self) { index in
                            Button {
                                currentPath = PathProvider.allPaths[index]
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    isOpen = false
                                }
                            } label: {
                                HStack {
                                    Image(systemName: PathProvider.icon(for: PathProvider.allPaths[index]))
                                    Text(PathProvider.allPaths[index].name)
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.trailing, maxWidth / 4)
        .offset(x: isOpen ? 0 : -maxWidth)
    }
}
