//
//  CanvasImageView.swift
//  Canvas
//
//  Created by Rafael Almeida on 28/03/25.
//

import SwiftUI

struct CanvasImageView: View {
    @State var image: Image
    @Binding var selectedImage: Image
    @State var position: CGPoint = CGPoint(x: 100, y: 100)
    @State private var scale: CGFloat = 1.0

    var body: some View {
        image
            .resizable()
            .frame(width: 140, height: 100)
            .border(selectedImage == image ? Color.yellow : Color.clear, width: 4)
            .position(position)
            .scaleEffect(scale)
            .onTapGesture {
                selectedImage = image
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        guard selectedImage == image else { return }
                        position = value.location
                        snapToBorder()
                    }
            )
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        guard selectedImage == image else { return }
                        scale = value
                    }
            )
    }

    private func snapToBorder() {
        let screenBounds = UIScreen.main.bounds
        let margin: CGFloat = 100

        if position.x >= screenBounds.width - margin && position.x <= screenBounds.width - 70.0 {
            position.x = screenBounds.width - 70.0
        } else if position.x <= margin && position.x >= 70 {
            position.x = 70
        }

        if position.y >= screenBounds.height - margin && position.y <= screenBounds.height - 50.0 {
            position.y = screenBounds.height - 50.0
        } else if position.y <= margin && position.y >= 50 {
            position.y = 50
        }
    }
}
