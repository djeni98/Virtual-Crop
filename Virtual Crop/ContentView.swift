import SwiftUI

struct ContentView: View {
    @State private var uiimage = UIImage(named: "image-900-500")!
    @State private var scale: CGFloat = 1.0
    @State private var offset = CGSize.zero

    @State private var progressingScale: CGFloat = 1.0
    @State private var progressingOffset = CGSize.zero

    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                progressingOffset = value.translation
            }
            .onEnded { value in
                offset = sum(value.translation, offset)
                progressingOffset = .zero
            }
    }

    var scaleGesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                progressingScale = value.magnitude
            }
            .onEnded { value in
                scale *= value
                progressingScale = 1.0
            }
    }

    var body: some View {
        ZStack {
            Image(uiImage: uiimage)
                .scaleEffect(scale * progressingScale)
                .offset(sum(offset, progressingOffset))
        }
        .gesture(dragGesture)
        .simultaneousGesture(scaleGesture)
    }

    func sum(_ a: CGSize, _ b: CGSize) -> CGSize {
        return CGSize(width: a.width + b.width, height: a.height + b.height)
    }
}

#Preview {
    ContentView()
}
