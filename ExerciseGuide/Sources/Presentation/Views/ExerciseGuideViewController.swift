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
import SnapKit
import SwiftUI

class ExerciseGuideViewController: UIViewController {
    private let viewModel: ExerciseGuideViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: VideoTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 160
        return tableView
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
        
        viewModel.fetchExerciseGuide(age: nil, exercise: nil, level: nil)
        configureUI()
        bind()
    }
    
    func configureUI() {
        navigationItem.title = "국민체력 100"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchVideo))
        view.backgroundColor = .systemBackground
        
        let vc = UIHostingController(rootView: PickerView(viewModel: viewModel))
        let swiftuiView = vc.view!
        view.addSubview(swiftuiView)
        view.addSubview(tableView)
        
        swiftuiView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(8)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(swiftuiView.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        vc.didMove(toParent: self)
    }
    
    func bind() {
        viewModel.$exerciseGuides
            .receive(on: DispatchQueue.main)
            .sink { [weak self] exerciseGuides in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    @objc func searchVideo() {
        
    }
}

extension ExerciseGuideViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.exerciseGuides.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as? VideoTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: viewModel.exerciseGuides[indexPath.item])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as? VideoTableViewCell else {
            return
        }
        let urlString = "http://openapi.kspo.or.kr/web/video/\(viewModel.exerciseGuides[indexPath.item].file_nm)"
        guard let url = URL(string: urlString) else { return }
        
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true) {
            player.play()
        }
    }
}
