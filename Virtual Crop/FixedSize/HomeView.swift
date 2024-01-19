import SwiftUI

struct FixedSizeHomeView: View {
    static let cropSize = CGSize(width: 200, height: 200)

    private let columns = [GridItem(), GridItem(), GridItem()]
    private var size: CGSize { FixedSizeHomeView.cropSize }

    @State private var imagesInfo = [
        FixedSizeImageInfo(uiimage: UIImage(named: "image-900-500")!, 
                           scale: nil,
                           offset: nil)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 40) {
                    ForEach(imagesInfo) { info in
                        let destination = FixedSizeEditImageView(info: info, allImages: $imagesInfo)
                        NavigationLink(destination: destination) {
                            FixedSizeImageVisualizerView(imageInfo: info)
                        }
                    }

                    NavigationLink(destination: FixedSizeNewImageView(allImages: $imagesInfo)) {
                        buttonAdd
                    }

                }
            }
            .navigationTitle("Fixed Size Example")
        }
    }
    
    var buttonAdd: some View {
        Circle().stroke().overlay {
            HStack {
                Image(systemName: "plus")
                Text("Add")
            }
        }
        .frame(width: size.width, height: size.height)
    }
}

#Preview {
    FixedSizeHomeView()
}
