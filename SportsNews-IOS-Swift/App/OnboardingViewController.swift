//
//  OnboardingViewController.swift
//  SportsNews-IOS-Swift
//
//  Created by Abdo Allam  on 08/06/2025.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        titleLabel.text = "Welcome to SportsNews"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        imageView.image = UIImage(named: "onboarding2")
        imageView.contentMode = .scaleAspectFit

        getStartedButton.setTitle("Get Started", for: .normal)
        getStartedButton.backgroundColor = .systemBlue
        getStartedButton.setTitleColor(.white, for: .normal)
        getStartedButton.layer.cornerRadius = 10
        getStartedButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    }

    @IBAction func getStartedTapped(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")


        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mainVC = storyboard.instantiateInitialViewController() else {
            return
        }

        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = mainVC
            window.makeKeyAndVisible()
        }
    }
}
