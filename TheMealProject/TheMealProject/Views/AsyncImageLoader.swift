import SwiftUI

struct AsyncImageLoader: View {
    @State private var imageData: Data?
    @State private var isLoading = true
    @State private var loadFailed = false
    let url: String

    var body: some View {
        Group {
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if loadFailed {
                Image(systemName: "photo") // Placeholder for failed load
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView()
                    .onAppear(perform: loadImage)
            }
        }
    }

    private func loadImage() {
        guard let imageUrl = URL(string: url) else { return }

        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, error == nil {
                    self.imageData = data
                    self.isLoading = false
                } else {
                    self.loadFailed = true
                }
            }
        }.resume()
    }
}

