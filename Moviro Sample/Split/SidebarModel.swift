//
//  SidebarModel.swift
//  Moviro Sample
//

import Moviro

// MARK: - Model

@Observable
final class SidebarModel: Model<SidebarRouter> {

    let items = ["First Item", "Second Item", "Third Item"]
}
