//
//  TangoApp.swift
//  Tango
//
//  Created by Глеб Бурштейн on 31.10.2020.
//

import PhotosUI
import LocalAuthentication
import SwiftUI
import AVKit

@main
struct TangoApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @StateObject var sessionVM = SessionViewModel()
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if !sessionVM.isLogged {
                    LoginView()
                } else {
                    TabbedPageView()
                }
            }
            .environmentObject(sessionVM)
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .accentColor(isDarkMode ? .AccentColorLight : .AccentColorDark)
            .onAppear() {
                UIApplication.shared.addTapGestureRecognizer()
                if Session.shared.token != "" {
                    sessionVM.authenticateWithoutPass()
                }
                PHPhotoLibrary.requestAuthorization { status in
                    guard status == .authorized else { return }
                }
                
            }
        }
    }
}

extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}

extension UINavigationController {
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask     {
        return .all
    }
}

extension UITabBarController {
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask     {
        return .all
    }
}

extension AVPlayerViewController {
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask     {
        return .all
    }
}
