//
//  DeepLink.swift
//  Moviro Sample
//

import Moviro

// MARK: - Step

/// One step of a deep link: what goes on screen next, from where the step
/// before it left off.
enum DeepLinkStep: String, CaseIterable, Identifiable, Codable {
    case push
    case sheet
    case fullScreen
    case popover
    case sheetWithStack
    case fullScreenWithStack

    var id: Self { self }

    var title: String {
        switch self {
        case .push: "Push"
        case .sheet: "Sheet"
        case .fullScreen: "Full Screen"
        case .popover: "Popover"
        case .sheetWithStack: "Sheet with Stack"
        case .fullScreenWithStack: "Full Screen with Stack"
        }
    }

    var systemImage: String {
        switch self {
        case .push: "arrow.right.square"
        case .sheet: "rectangle.bottomhalf.inset.filled"
        case .fullScreen: "rectangle.inset.filled"
        case .popover: "bubble.middle.top"
        case .sheetWithStack: "rectangle.stack"
        case .fullScreenWithStack: "rectangle.stack.fill"
        }
    }

    /// A "with Stack" step presents a `NavigationStackRouter`, so the steps
    /// after it can push again.
    var bringsAStack: Bool {
        self == .sheetWithStack || self == .fullScreenWithStack
    }

    /// Whether the step after this one may be a push: only a push or a
    /// "with Stack" step leaves a push router to push from.
    var leavesAPushRouter: Bool {
        self == .push || bringsAStack
    }

    /// A push needs a stack to land on — Home's, or the one a "with Stack"
    /// step brought; everything else can follow anything.
    static func canAppend(_ step: DeepLinkStep, after previous: DeepLinkStep?) -> Bool {
        step != .push || (previous?.leavesAPushRouter ?? true)
    }

    var modalTransition: AnyModalRouter.Transition {
        switch self {
        case .sheet, .sheetWithStack: .sheet
        case .fullScreen, .fullScreenWithStack: .fullScreen
        case .popover: .popover()
        case .push: .sheet
        }
    }
}

// MARK: - Link

struct DeepLink: Equatable, Codable {

    var steps: [DeepLinkStep] = []

    /// push · push · present · present · present with stack · push · push ·
    /// present · present · present.
    static let example = DeepLink(steps: [
        .push, .push, .sheet, .popover, .fullScreenWithStack, .push, .push, .sheet, .sheet, .fullScreen
    ])

    var isValid: Bool {
        var previous: DeepLinkStep?
        for step in steps {
            guard DeepLinkStep.canAppend(step, after: previous) else { return false }
            previous = step
        }
        return true
    }

    /// Creates every router of the link and links them together, hanging the
    /// first off `start` — all in one go, before anything is on screen. Moviro
    /// shows each screen once the one under it has appeared, which is what a
    /// deep link arriving at the app relies on.
    @MainActor
    func open(from start: AnyPushRouter) {
        var cursor = Cursor.push(start)
        for (index, step) in steps.enumerated() {
            let context = DeepLinkStepContext(index: index, steps: steps)
            switch step {
            case .push:
                guard case .push(let current) = cursor else { return }
                let router = DeepLinkPushStepRouter(context: context)
                current.pushed = router
                cursor = .push(router)
            case .sheet, .fullScreen, .popover:
                let router = DeepLinkModalStepRouter(context: context, transition: step.modalTransition)
                cursor.present(router)
                cursor = .modal(router)
            case .sheetWithStack, .fullScreenWithStack:
                let root = DeepLinkPushStepRouter(context: context)
                let stack = NavigationStackRouter(root: root, transition: step.modalTransition)
                cursor.present(stack)
                cursor = .push(root)
            }
        }
    }

    /// Where the next step opens from: a push router pushes and presents
    /// (through its stack); a modal router only presents.
    private enum Cursor {
        case push(AnyPushRouter)
        case modal(AnyModalRouter)

        @MainActor
        func present(_ router: AnyModalRouter) {
            switch self {
            case .push(let pushRouter): pushRouter.presented = router
            case .modal(let modalRouter): modalRouter.presented = router
            }
        }
    }
}

// MARK: - Step Context

/// What a step's screen knows: its place in the link and the whole link.
struct DeepLinkStepContext {

    let index: Int
    let steps: [DeepLinkStep]

    var step: DeepLinkStep { steps[index] }
    var number: Int { index + 1 }

    /// What Close does for this step's screen.
    var closeDescription: String {
        switch step {
        case .push:
            index == 0 ? "Pops back to where the link opened from." : "Pops back to step \(index)."
        case .sheet, .fullScreen, .popover:
            "Dismisses this \(step.title.lowercased())."
        case .sheetWithStack, .fullScreenWithStack:
            "Dismisses the stack this screen is the root of."
        }
    }
}
