//
//  FadeCoverRouter.swift
//  Moviro Sample
//

import Moviro

// MARK: - Routable

@MainActor
protocol FadeCoverRoutable {
    func showFadeCover(style: FadeCoverStyle)
}

extension FadeCoverRoutable where Self: AnyPushRouter {
    func showFadeCover(style: FadeCoverStyle) {
        presented = FadeCoverRouter(style: style)
    }
}

// MARK: - Style

/// Which transition the cover's content comes and goes with.
enum FadeCoverStyle: String, CaseIterable, Identifiable {
    case fade, scale

    var id: Self { self }

    var title: String {
        switch self {
        case .fade: "Fade"
        case .scale: "Scale"
        }
    }

    var systemImage: String {
        switch self {
        case .fade: "sun.haze.fill"
        case .scale: "arrow.up.left.and.arrow.down.right"
        }
    }

    /// The cover is put up and taken down without animation over a clear
    /// background; only its content moves, with this transition.
    var transition: AnyModalRouter.Transition {
        switch self {
        case .fade:
            .fullScreen(
                transition: .opacity,
                animation: .easeOut(duration: 0.45),
                removal: .easeIn(duration: 0.35)
            )
        case .scale:
            .fullScreen(
                transition: .scale(scale: 0.8).combined(with: .opacity),
                animation: .spring(duration: 0.5, bounce: 0.3),
                removal: .easeIn(duration: 0.25)
            )
        }
    }
}

// MARK: - Model

@Observable
final class FadeCoverModel: Model<FadeCoverRouter> {

    let style: FadeCoverStyle

    init(style: FadeCoverStyle, router: FadeCoverRouter) {
        self.style = style
        super.init(router: router)
    }

    func dismiss() {
        router?.close()
    }
}

// MARK: - Router

/// A full-screen cover with a transition of its own: no system slide. The
/// content fades or scales in over Home, and `close()` runs the transition
/// backwards before the cover goes.
final class FadeCoverRouter: ModalRouter<FadeCoverView> {

    private let style: FadeCoverStyle

    init(style: FadeCoverStyle) {
        self.style = style
        super.init(transition: style.transition)
    }

    override func makeModel() -> FadeCoverModel {
        FadeCoverModel(style: style, router: self)
    }
}
