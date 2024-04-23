//
//  ToolbarView.swift
//  NewsToDay
//
//  Created by Келлер Дмитрий on 10.04.2024.
//

import SwiftUI
import DS

struct ToolbarView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isOpenURL: Bool
    let isBookmark: Bool
    let readAction: () -> Void
    let shareAction: () -> Void
    
    var body: some View {
        HStack {
            RoundButton(
                action:  { dismiss() },
                imageName: "xmark"
            )
            .padding(.leading, 12)
            Spacer()

            HStack {
                Spacer()
                RoundButton(
                    action: { isOpenURL.toggle() },
                    imageName: "doc.fill"
                )
                
                RoundButton(
                    action:  { shareAction() },
                    imageName: "arrowshape.turn.up.forward.fill"
                )
                
                RoundButton(
                    action: { readAction() },
                    imageName: !isBookmark ? "bookmark" : "bookmark.fill"
                )
                Spacer()
                .padding(.trailing, 8)
            }
        }
    }
}
