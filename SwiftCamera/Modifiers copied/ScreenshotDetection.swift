//
//  ScreenshotDetection.swift
//  Backflip
//
//  Created by Patrick Wilson on 2/13/22.
//

import Foundation
import SwiftUI

// Deprecated

extension View {
    func screenshotDetection() -> some View {
        modifier(ScreenshotDetection())
    }
}
struct ScreenshotDetection: ViewModifier { // onScreenshotNotification
    @State private var isPresented = false
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .onNotification(UIApplication.userDidTakeScreenshotNotification) { notification in
                    self.screenshotTaken(notification: notification)
                    self.isPresented = true
                }
                .popup(isPresented: $isPresented,
                       type: .toast,
                       position: .top,
                       animation: Animation.spring(dampingFraction: 0.5).speed(2),
					   autohideIn: 5.0,
					   closeOnTap: true,
                       closeOnTapOutside: true,
                       backgroundColor: Color.clear
                ) {
                    ScreenshotToast()
                }
        }
    }
    
    func screenshotTaken(notification: Notification) {
        print("*021122* \(type(of: self)), \(#function) |> todo: display screenshot thumb \(notification.userInfo.loggable)")
    }
}
