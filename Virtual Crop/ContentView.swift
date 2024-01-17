import SwiftUI

struct ContentView: View {
    @State private var uiimage = UIImage(named: "image-900-500")!
    @State private var scale: CGFloat = 1.0
    @State private var offset = CGSize.zero

    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                self.offset = value.translation
            }
    }

    var scaleGesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                self.scale = value.magnitude
            }
    }

    var body: some View {
        ZStack {
            Image(uiImage: uiimage)
                .scaleEffect(scale)
                .offset(offset)
        }
        .gesture(dragGesture)
        .simultaneousGesture(scaleGesture)
    }
}

#Preview {
    ContentView()
}
