//
//  SheetRouter.swift
//  Moviro Sample
//

import Moviro

// MARK: - Routable

@MainActor
protocol SheetRoutable {
    func showSheet()
}

extension SheetRoutable where Self: AnyModalRouter {
    func showSheet() {
        presented = SheetRouter()
    }
}

extension SheetRoutable where Self: AnyPushRouter {
    func showSheet() {
        presented = SheetRouter()
    }
}

// MARK: - Model

@Observable
final class SheetModel: Model<SheetRouter> {

    func dismiss() {
        router?.close()
    }
}

// MARK: - Router

/// Modal router using `.sheet` transition.
final class SheetRouter: ModalRouter<SheetView> {

    init() {
        super.init(transition: .sheet)
    }

    override func makeModel() -> SheetModel {
        SheetModel(router: self)
    }
}
