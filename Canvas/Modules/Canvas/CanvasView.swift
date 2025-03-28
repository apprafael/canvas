//
//  CanvasView.swift
//  Canvas
//
//  Created by Rafael Almeida on 27/03/25.
//

import SwiftUI

struct CanvasView: View {
    @State private var isSheetPresented = false

    var body: some View {
        Spacer()
        setTabView()
            .sheet(isPresented: $isSheetPresented) {
                ImagesView()
            }
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
