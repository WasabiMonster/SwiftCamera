//
//  GetGlobalFrame.swift
//  Backflip
//
//  Created by Patrick Wilson on 2/2/22.
//

import SwiftUI

struct GetGlobalFrame: ViewModifier {
    @Binding var globalFrame: CGRect

    init(globalFrame: Binding<CGRect>) {
        self._globalFrame = globalFrame
        print("*020222* \(type(of: self)), \(#function) |> \(globalFrame)")
    }

    func body(content: Content) -> some View {
        Text("placeholder")
        content.background(
            GeometryReader { (proxy: GeometryProxy) -> EmptyView in
                if globalFrame != proxy.frame(in: .global) {
                    DispatchQueue.main.async {
                        globalFrame = proxy.frame(in: .global)
                    }
                }
                return EmptyView()
            }
        )
    }
}
