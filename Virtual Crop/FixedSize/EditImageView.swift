import SwiftUI

extension FixedSizeImageInfo {
    func toEditorInput() -> CropperEditorView.Input {
        return .init(uiimage: uiimage, scale: scale, offset: offset)
    }
}

struct FixedSizeEditImageView: View {
    let info: FixedSizeImageInfo
    @Binding var allImages: [FixedSizeImageInfo]

    @Environment(\.dismiss) private var dismiss
    @State private var output = CropperEditorView.Output(scale: 1, offset: .zero)

    private var size: CGSize { FixedSizeHomeView.cropSize }

    var body: some View {
        ZStack {
            CropperEditorView(input: info.toEditorInput(), output: $output)
            Circle().stroke()
                .frame(width: size.width, height: size.width)
        }
        .ignoresSafeArea()
        .navigationTitle("Edit Image")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save", action: save)
            }
        }
    }

    func save() {
        guard let index = allImages.firstIndex(where: { $0.id == info.id }) else {
            return
        }

        allImages[index].scale = output.scale
        allImages[index].offset = output.offset

        dismiss()
    }
}

#Preview {
    NavigationStack {
        FixedSizeEditImageView(
            info: .init(uiimage: UIImage(named: "cachorro")!),
            allImages: .constant([])
        )
    }
}
