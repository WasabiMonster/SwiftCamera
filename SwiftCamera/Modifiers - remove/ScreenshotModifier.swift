//
//  ScreenshotModifier.swift
//  Backflip
//
//  Created by Patrick Wilson on 2/11/22.
//

import Foundation
import SwiftUI

// WIP

extension View {
    func screenshotModifier() -> some View {
        modifier(ScreenshotModifier())
    }
}
struct ScreenshotModifier: ViewModifier {
    @State private var isPresented = false
    
    func body(content: Content) -> some View {
        content
            .onNotification(UIApplication.userDidTakeScreenshotNotification) { notification in
                self.screenshotTaken(notification: notification)
                self.isPresented = true
            }
            .popup(isPresented: $isPresented, type: .floater(verticalPadding: 20)) {
                Text("Screenshot")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .background(Color.primaryDarkGreen)
                    .onTapGesture {
                        self.isPresented = false
                    }
            }
            // .frame(width: 300.0, height: 250.0) :(
    }
    
    func screenshotTaken(notification: Notification) {
        print("*021122* \(type(of: self)), \(#function) |> still works???? \(notification.userInfo.loggable)")
        // guard let screenshot = notification.userInfo?[UIApplication.userDidTakeScreenshotNotification] as? UIImage else {
        // return
        // }
        // todo: Maybe post to db here? or straight up alert on Slack
        // self.screenshot = screenshot
        // print("*021222thisascrenslht* \(type(of: self)), \(#function) |> \(String(describing: self.screenshot))")
    }
}

// https://www.hackingwithswift.com/books/ios-swiftui/custom-modifiers
