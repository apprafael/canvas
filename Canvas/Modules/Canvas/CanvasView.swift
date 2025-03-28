//
//  CanvasView.swift
//  Canvas
//
//  Created by Rafael Almeida on 27/03/25.
//

import SwiftUI

struct CanvasView: View {
    @State private var isSheetPresented = false
    @State private var selectedImage: Image = Image("placeholder")
    @State private var position: CGPoint = CGPoint(x: 100, y: 100)

    var body: some View {
        setCanvasImage()
        Spacer()
        setTabView()
            .sheet(isPresented: $isSheetPresented) {
                ImagesView(selectedImage: $selectedImage)
            }
    }

    private func setCanvasImage() -> some View {
        selectedImage
            .resizable()
            .frame(width: 100, height: 100)
            .position(position)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        position = value.location
                    }
            )
    }

    private func setTabView() -> some View {
        HStack {
            Button {
                isSheetPresented = true
            } label: {
                Image(systemName: "plus")
                    .frame(height: 50)
            }
        }
        .frame(height: 100)
    }
}
