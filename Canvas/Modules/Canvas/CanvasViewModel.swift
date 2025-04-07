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
    var canvasSize: CGSize = CGSize()

    init(images: [CanvasImageModel] = []) {
        self.images = images
    }

    func snapToImagesIfNeeded() {
        let selectedImageIndex = images.firstIndex(where: {$0.id == selectedImageID }) ?? 0

        for index in 0..<images.count {
            if images[index].id == selectedImageID {
                continue
            }

            let combinedWidth = (images[selectedImageIndex].width + images[index].width)/2
            let combinedHeight = (images[selectedImageIndex].height + images[index].height)/2

            if (images[selectedImageIndex].position.x - images[index].position.x) >= combinedWidth &&
                (images[selectedImageIndex].position.x - images[index].position.x) <= combinedWidth + 20 {
                images[selectedImageIndex].position.x = images[index].position.x + combinedWidth
                images[index].showRightSnapLine = true
            } else {
                images[index].showRightSnapLine = false
            }

            if (images[index].position.x - images[selectedImageIndex].position.x) >= combinedWidth &&
                (images[index].position.x - images[selectedImageIndex].position.x) <= combinedWidth + 20 {
                images[selectedImageIndex].position.x = images[index].position.x - combinedWidth
                images[index].showLeftSnapLine = true
            } else {
                images[index].showLeftSnapLine = false
            }

            if (images[selectedImageIndex].position.y - images[index].position.y) >= combinedHeight &&
                (images[selectedImageIndex].position.y - images[index].position.y) <= combinedHeight + 20 {
                images[selectedImageIndex].position.y = images[index].position.y + combinedHeight
                images[index].showBottomSnapLine = true
            } else {
                images[index].showBottomSnapLine = false
            }

            if (images[index].position.y - images[selectedImageIndex].position.y) >= combinedHeight &&
                (images[index].position.y - images[selectedImageIndex].position.y) <= combinedHeight + 20 {
                images[selectedImageIndex].position.y = images[index].position.y - combinedHeight
                images[index].showTopSnapLine = true
            } else {
                images[index].showTopSnapLine = false
            }

        }
    }

    func snapToBorderIfNeeded() {
        let selectedImageIndex = images.firstIndex(where: {$0.id == selectedImageID }) ?? 0
        let margin: CGFloat = 100
        let halfWidth = images[selectedImageIndex].width / 2
        let halfHeight = images[selectedImageIndex].height / 2

        if images[selectedImageIndex].position.x >= canvasSize.width - margin && images[selectedImageIndex].position.x <= canvasSize.width - halfWidth {
            images[selectedImageIndex].position.x = canvasSize.width - halfWidth
        } else if images[selectedImageIndex].position.x <= margin && images[selectedImageIndex].position.x >= halfWidth {
            images[selectedImageIndex].position.x = halfWidth
        }

        if images[selectedImageIndex].position.y >= canvasSize.height - margin && images[selectedImageIndex].position.y <= canvasSize.height - halfHeight {
            images[selectedImageIndex].position.y = canvasSize.height - halfHeight
        } else if images[selectedImageIndex].position.y <= margin && images[selectedImageIndex].position.y >= halfHeight {
            images[selectedImageIndex].position.y = halfHeight
        }
    }
}
