import Foundation

struct Slide: Identifiable{
    let id = UUID()
    let header: String
    let description: String
    let imageName: String
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let imagePadding: CGFloat
}
