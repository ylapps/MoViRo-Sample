//
//  DeepLinkStepRouter.swift
//  Moviro Sample
//

import Moviro

// MARK: - Interface

@MainActor
protocol DeepLinkStepRouterInterface: ClosableRouter {}

// MARK: - Model

@Observable
final class DeepLinkStepModel: Model<any DeepLinkStepRouterInterface> {

    let context: DeepLinkStepContext

    init(context: DeepLinkStepContext, router: any DeepLinkStepRouterInterface) {
        self.context = context
        super.init(router: router)
    }

    /// `close()` pops a pushed step, dismisses a modal one, and dismisses the
    /// whole stack for a step that is a stack's root.
    func close() {
        router?.close()
    }
}

// MARK: - Routers

/// A step that is pushed: onto Home's stack, or onto the one a "with Stack"
/// step brought.
final class DeepLinkPushStepRouter: PushRouter<DeepLinkStepView>, DeepLinkStepRouterInterface {

    private let context: DeepLinkStepContext

    init(context: DeepLinkStepContext) {
        self.context = context
        super.init()
    }

    override func makeModel() -> DeepLinkStepModel {
        DeepLinkStepModel(context: context, router: self)
    }
}

/// A step that is presented as a sheet, a full-screen cover or a popover.
final class DeepLinkModalStepRouter: ModalRouter<DeepLinkStepView>, DeepLinkStepRouterInterface {

    private let context: DeepLinkStepContext

    init(context: DeepLinkStepContext, transition: AnyModalRouter.Transition) {
        self.context = context
        super.init(transition: transition)
    }

    override func makeModel() -> DeepLinkStepModel {
        DeepLinkStepModel(context: context, router: self)
    }
}
