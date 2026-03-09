//
//  ImageViewer.swift
//  swift-qwz-ui
//
//  Created by david on 2026/3/9.
//

import SwiftUI
import Lightbox

public enum ImageItem {
    case image(UIImage)
    case imageURL(URL)
    
    case video(_ previewImage: UIImage, _ url: URL?)
    case videoURL(_ previewImageURL: URL, _ url: URL?)
    
    case customURL(URL, _ userInfo: Any?)
}

public struct ImageViewer: UIViewControllerRepresentable {
    public var imageItems: [ImageItem]
    
    public init(imageItems: [ImageItem]) {
        self.imageItems = imageItems
    }
    
    public class Coordinator: NSObject, LightboxControllerTapDelegate {
        public override init() {
            
        }
        
        public func lightboxController(_ controller: LightboxController, didTap image: LightboxImage, at index: Int) {
            
        }
        
        public func lightboxController(_ controller: LightboxController, didDoubleTap image: LightboxImage, at index: Int) {
            
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<ImageViewer>) -> LightboxController {
        let vc = LightboxController(images: imageItems.map {
            switch $0 {
            case .image(let image):
                return LightboxImage(image: image)
                
            case .imageURL(let url):
                return LightboxImage(imageURL: url)
                
            case .video(let previewImage, let url):
                return LightboxImage(image: previewImage, videoURL: url)
                
            case .videoURL(let previewImageURL, let url):
                return LightboxImage(imageURL: previewImageURL, videoURL: url)
                
            case .customURL(let url, _):
                return LightboxImage(imageURL: url)
            }
        })
        vc.imageTapDelegate = context.coordinator
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: LightboxController, context: UIViewControllerRepresentableContext<ImageViewer>) {
        // Don't need to update
    }
}
