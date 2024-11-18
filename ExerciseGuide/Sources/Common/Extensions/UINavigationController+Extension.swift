//
//  UINavigationController+Extension.swift
//  ExerciseGuide
//
//  Created by 이인호 on 11/16/24.
//

import UIKit

extension UINavigationController {
    func setupBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .systemBackground
        
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.white]
        
        // 네비게이션 바 라인 제거
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        
        // 타이틀 위치 조정
        appearance.titlePositionAdjustment = UIOffset(horizontal: -(view.frame.width/2),
                                                      vertical: 0)
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
    }
}
