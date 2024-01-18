import SwiftUI

struct VisualizerAndCropperEditorView: View {
    @State private var uiimage = UIImage(named: "image-900-500")!
    @State private var scale: CGFloat = 1.0
    @State private var offset = CGSize.zero

    var body: some View {
            VStack {
                let width: CGFloat = 130
                let height: CGFloat = 200

                CropperEditorView(uiimage: $uiimage, scale: $scale, offset: $offset)
                    .frame(width: width, height: height)
                    .overlay {
                        Rectangle().stroke(.black)
                    }
                    .zIndex(10)

                Spacer()

                Image(uiImage: uiimage)
                    .scaleEffect(scale)
                    .offset(offset)
                    .frame(width: width, height: height)
                    .clipShape(Rectangle())
            }
        }
}
