//
//  CanvasViewModel.swift
//  Canvas
//
//  Created by Rafael Almeida on 04/04/25.
//

import SwiftUI

class CanvasViewModel: ObservableObject {
    @Published var selectedImageID: UUID = UUID()
    @Published var images: [CanvasImageModel]

    init(images: [CanvasImageModel] = []) {
        self.images = images
    }

    func snapToImagesIfNeeded() {
        let selectedImageIndex = images.firstIndex(where: {$0.id == selectedImageID }) ?? 0

        for index in 0..<images.count {
            if images[index].id == selectedImageID {
                continue
            }

            if (images[selectedImageIndex].position.x - images[index].position.x) >= 140 &&
                (images[selectedImageIndex].position.x - images[index].position.x) <= 160 {
                images[selectedImageIndex].position.x = images[index].position.x + 140
            }

            if (images[index].position.x - images[selectedImageIndex].position.x) >= 140 &&
                (images[index].position.x - images[selectedImageIndex].position.x) <= 160 {
                images[selectedImageIndex].position.x = images[index].position.x - 140
            }

            if (images[selectedImageIndex].position.y - images[index].position.y) >= 100 &&
                (images[selectedImageIndex].position.y - images[index].position.y) <= 120 {
                images[selectedImageIndex].position.y = images[index].position.y + 100
            }

            if (images[index].position.y - images[selectedImageIndex].position.y) >= 100 &&
                (images[index].position.y - images[selectedImageIndex].position.y) <= 120 {
                images[selectedImageIndex].position.y = images[index].position.y - 100
            }
        }
    }

    func snapToBorderIfNeeded() {
        let selectedImageIndex = images.firstIndex(where: {$0.id == selectedImageID }) ?? 0
        let screenBounds = UIScreen.main.bounds
        let margin: CGFloat = 100

        if images[selectedImageIndex].position.x >= screenBounds.width - margin && images[selectedImageIndex].position.x <= screenBounds.width - 70.0 {
            images[selectedImageIndex].position.x = screenBounds.width - 70.0
        } else if images[selectedImageIndex].position.x <= margin && images[selectedImageIndex].position.x >= 70 {
            images[selectedImageIndex].position.x = 70
        }

        if images[selectedImageIndex].position.y >= screenBounds.height - margin && images[selectedImageIndex].position.y <= screenBounds.height - 50.0 {
            images[selectedImageIndex].position.y = screenBounds.height - 50.0
        } else if images[selectedImageIndex].position.y <= margin && images[selectedImageIndex].position.y >= 50 {
            images[selectedImageIndex].position.y = 50
        }
    }
}
