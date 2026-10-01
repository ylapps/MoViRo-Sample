//
//  HomeRouter.swift
//  Moviro Sample
//

import Moviro

// MARK: - Interface

@MainActor
protocol HomeRouterInterface:
    DetailRoutable,
    PushSwitchRoutable,
    SheetRoutable,
    FullScreenRoutable,
    ModalSwitchRoutable,
    ColorPickerRoutable,
    NicknameRoutable,
    AlertRoutable {}

// MARK: - Router

/// Push router for the home screen. Coordinates all navigation from the home view.
final class HomeRouter: PushRouter<HomeView>, HomeRouterInterface {

    override func makeModel() -> HomeModel {
        HomeModel(router: self)
    }
}

// MARK: - Navigation Stack

/// Wraps the home push flow in a `NavigationStack`.
final class HomeNavigationStackRouter: NavigationStackRouter {

    init() {
        super.init(root: HomeRouter(), transition: .fullScreen)
    }
}
