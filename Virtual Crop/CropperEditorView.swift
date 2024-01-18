import SwiftUI

struct CropperEditorView: View {
    @Binding var uiimage: UIImage
    @Binding var scale: CGFloat
    @Binding var offset: CGSize

    @State private var progressingScale: CGFloat = 1.0
    @State private var progressingOffset = CGSize.zero

    @State private var aspectFitImageSize = CGSize.zero
    private var aspectFitScale: CGFloat {
        aspectFitImageSize.width / uiimage.size.width
    }

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
                .resizable()
                .background(
                    GeometryReader { g in
                        Color.gray.opacity(0).onAppear {
                            aspectFitImageSize = g.size
                            scale = scale / aspectFitScale
                        }
                    }
                )
                .scaleEffect(scale * progressingScale)
                .offset(sum(offset, progressingOffset))
                .aspectRatio(contentMode: .fit)
        }
        .gesture(dragGesture)
        .simultaneousGesture(scaleGesture)
    }

    func sum(_ a: CGSize, _ b: CGSize) -> CGSize {
        return CGSize(width: a.width + b.width, height: a.height + b.height)
    }
}
