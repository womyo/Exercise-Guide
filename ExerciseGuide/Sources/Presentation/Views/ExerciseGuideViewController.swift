//
//  ExerciseGuideViewController.swift
//  ExerciseGuide
//
//  Created by 이인호 on 10/31/24.
//

import UIKit
import Combine
import AVKit
import AVFoundation

class ExerciseGuideViewController: UITabBarController {
    
    private let viewModel: ExerciseGuideViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Play Video", for: .normal)
        button.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: ExerciseGuideViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        viewModel.fetchExerciseGuide()
        configureUI()
        bind()
    }
    
    func configureUI() {
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func bind() {
        viewModel.$exerciseGuides
            .receive(on: DispatchQueue.main)
            .sink { [weak self] exerciseGuides in
                print(exerciseGuides)
            }
            .store(in: &cancellables)
    }
    
    @objc func playVideo(_ sender: UIButton) {
        let urlString = "http://openapi.kspo.or.kr/web/video/\(viewModel.exerciseGuides[9].file_nm)"
        guard let url = URL(string: urlString) else { return }
        
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true) {
            player.play()
        }
    }

}
