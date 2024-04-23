//
//  SafariView.swift
//  NewsToDay
//
//  Created by dsm 5e on 24.03.2024.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {

    // MARK: Stored Properties

    let url: URL

    // MARK: Methods

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let configuration = SFSafariViewController.Configuration()
        configuration.barCollapsingEnabled = false
        return SFSafariViewController(url: url, configuration: configuration)
    }

    func updateUIViewController(_ controller: SFSafariViewController, context: Context) {

    }

}
struct SafariView_Previews: PreviewProvider {
    static var previews: some View {
        SafariView(url: URL(string: "https://www.google.com")!)
    }
}
