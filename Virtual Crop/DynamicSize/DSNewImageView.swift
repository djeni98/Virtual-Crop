import SwiftUI

struct DynamicSizeNewImageView: View {
    @Binding var allImages: [DynamicSizeImageInfo]

    @Environment(\.dismiss) private var dismiss
    @State private var imageName = "cachorro"
    @State private var output = CropperEditorView.Output(scale: 1, offset: .zero)

    private var size: CGSize { DynamicSizeHomeView.cropSize }
    private var uiimage: UIImage { UIImage(named: imageName)! }

    var body: some View {
        ZStack {
            CropperEditorView(input: .from(uiimage), output: $output)
            Circle().stroke()
                .frame(width: size.width, height: size.width)
        }
        .ignoresSafeArea()
        .navigationTitle("New Image")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Change Image") {
                    imageName = imageName == "cachorro" ? "image-900-500" : "cachorro"
                }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save", action: save)
            }
        }
    }

    func save() {
        allImages.append(.init(uiimage: uiimage,
                               scale: output.scale,
                               offset: output.offset,
                               cropperSize: size))

        dismiss()
    }
}
#Preview {
    NavigationStack {
        DynamicSizeNewImageView(allImages: .constant([]))
    }
}
