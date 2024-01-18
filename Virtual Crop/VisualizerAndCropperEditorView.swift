import SwiftUI

struct VisualizerAndCropperEditorView: View {
    private let uiimage = UIImage(named: "image-900-500")!
    @State private var info: CropperEditorView.Output = .init(scale: 1, offset: .zero)

    var body: some View {
            VStack {
                let width: CGFloat = 130
                let height: CGFloat = 200

                CropperEditorView(input: .from(uiimage), output: $info)
                    .frame(width: width, height: height)
                    .overlay {
                        Rectangle().stroke(.black)
                    }
                    .zIndex(10)

                Spacer()

                Image(uiImage: uiimage)
                    .scaleEffect(info.scale)
                    .offset(info.offset)
                    .frame(width: width, height: height)
                    .clipShape(Rectangle())
            }
        }
}
