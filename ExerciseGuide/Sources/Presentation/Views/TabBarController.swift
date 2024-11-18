//
//  TabBarController.swift
//  ExerciseGuide
//
//  Created by 이인호 on 11/19/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbarLayout()
        setupTabbarItems()
        selectedIndex = 0
    }
    
    private func setupTabbarLayout() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.shadowColor = .lightGray
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    private func setupTabbarItems() {
        let firstViewController = ExerciseGuideViewController(viewModel: ExerciseGuideViewModel(usecase: OpenAPI()))
        firstViewController.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let secondViewController = UIViewController()
        secondViewController.tabBarItem = UITabBarItem(
            title: "MY",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        let firstNavController = UINavigationController(rootViewController: firstViewController)
        firstNavController.setupBarAppearance()
        
        let secondNavController = UINavigationController(rootViewController: secondViewController)
        secondNavController.setupBarAppearance()
        
        viewControllers = [
            firstNavController,
            secondNavController
        ]
    }
}
