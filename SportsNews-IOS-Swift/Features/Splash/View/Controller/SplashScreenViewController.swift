//
//  SplashScreenViewController.swift
//  SportsNews-IOS-Swift
//
//  Created by mohamed Tajeldin on 07/06/2025.
//

import UIKit
import Lottie

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var animationView: UIView!
    private var lottieView: LottieAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        playLottieAnimation()
    }

    private func playLottieAnimation() {
        lottieView = LottieAnimationView(name: "goal2")
        lottieView.frame = animationView.bounds
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .playOnce
        lottieView.animationSpeed = 1.0
        animationView.addSubview(lottieView)

        lottieView.play { [weak self] finished in
            if finished {
                self?.navigateToMainScreen()
            } else {
                print("⚠️ Lottie animation did not complete.")
            }
        }
    }

    private func navigateToMainScreen() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = mainStoryboard.instantiateInitialViewController()

        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = scene.delegate as? SceneDelegate,
              let window = sceneDelegate.window else {
            return
        }

        window.rootViewController = mainVC
        window.makeKeyAndVisible()
    }
}

