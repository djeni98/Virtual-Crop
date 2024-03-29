import SwiftUI

struct CropperEditorView: View {
    var input: CropperEditorView.Input
    @Binding var output: CropperEditorView.Output

    @State private var scale: CGFloat = 1.0
    @State private var offset = CGSize.zero

    @State private var progressingScale: CGFloat = 1.0
    @State private var progressingOffset = CGSize.zero

    @State private var aspectFitImageSize = CGSize.zero
    private var aspectFitScale: CGFloat {
        aspectFitImageSize.width / input.uiimage.size.width
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

    var twoTapsGesture: some Gesture {
        TapGesture(count: 2)
            .onEnded {
                offset = .zero
                scale = 1
            }
    }

    var body: some View {
        ZStack {
            Color.gray

            Image(uiImage: input.uiimage)
                .resizable()
                .background(
                    GeometryReader { g in
                        Color.gray.opacity(0).onAppear {
                            aspectFitImageSize = g.size

                            if let inputScale = input.scale {
                                scale = inputScale / aspectFitScale
                            }

                            if let inputOffset = input.offset {
                                offset = inputOffset
                            }

                            output.scale = scale * aspectFitScale
                            output.offset = offset
                        }
                    }
                )
                .scaleEffect(scale * progressingScale)
                .offset(sum(offset, progressingOffset))
                .aspectRatio(contentMode: .fit)
        }
        .gesture(dragGesture)
        .simultaneousGesture(scaleGesture)
        .simultaneousGesture(twoTapsGesture)
        .onChange(of: scale) { value in
            output.scale = scale * aspectFitScale
        }
        .onChange(of: offset) { value in
            output.offset = offset
        }
    }

    func sum(_ a: CGSize, _ b: CGSize) -> CGSize {
        return CGSize(width: a.width + b.width, height: a.height + b.height)
    }
}

extension CropperEditorView {
    struct Input {
        var uiimage: UIImage
        var scale: CGFloat?
        var offset: CGSize?

        static func from(_ uiimage: UIImage, scale: CGFloat? = nil, offset: CGSize? = nil) -> Self {
            return Self(uiimage: uiimage, scale: scale, offset: offset)
        }
    }

    struct Output {
        var scale: CGFloat
        var offset: CGSize
    }
}

#Preview {
    VisualizerAndCropperEditorView()
}
