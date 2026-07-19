//
//  SampleAppRouter.swift
//  Moviro Sample
//

import Moviro

// MARK: - App Entry Point

/// Root router of the sample app.
@Observable
@MainActor
final class SampleAppRouter {

    let homeStack: HomeNavigationStackRouter

    init() {
        self.homeStack = HomeNavigationStackRouter()
    }
}

/// Convenience view for embedding the sample flow in a SwiftUI app or preview.
struct SampleRootView: View {

    @State private var router = SampleAppRouter()

    var body: some View {
        router.homeStack.makeView()
    }
}

#Preview("Sample App") {
    SampleRootView()
}
