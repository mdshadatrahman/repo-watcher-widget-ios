//
//  AuthenticationContextProvider.swift
//  RepoWatcher
//
//  Created by Shadat Rahman on 2/9/24.
//

import UIKit
import SwiftUI
import AuthenticationServices

class AuthenticationContextProvider: NSObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return UIWindow()
        }
        return window
    }
}
