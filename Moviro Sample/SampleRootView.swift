//
//  SampleRootView.swift
//  Moviro Sample
//

import Moviro

// MARK: - Root View

/// The app's root: a `NavigationStackRouter` held in `@State` and rendered with
/// `makeView()`. Every other screen is reached from its routers.
struct SampleRootView: View {

    @State private var router = HomeNavigationStackRouter()

    var body: some View {
        router.makeView()
    }
}

#Preview("Sample App") {
    SampleRootView()
}
