//
//  VideoTableViewCell.swift
//  ExerciseGuide
//
//  Created by 이인호 on 11/16/24.
//

import UIKit
import SnapKit
import Kingfisher

class VideoTableViewCell: UITableViewCell {

    static let identifier = "VideoTableViewCell"
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let videoLength: PaddingLabel = {
        let label = PaddingLabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.backgroundColor = UIColor.black.withAlphaComponent(0.3)

        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.textInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(videoLength)
        contentView.addSubview(titleLabel)
        contentView.addSubview(moreButton)
        
        thumbnailImageView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(8)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.height.equalTo(240)
        }
        
        videoLength.snp.makeConstraints {
            $0.trailing.equalTo(thumbnailImageView).offset(-8)
            $0.bottom.equalTo(thumbnailImageView).offset(-8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(8)
            $0.leading.equalTo(contentView.snp.leading).offset(8)
            $0.bottom.lessThanOrEqualTo(contentView.snp.bottom).offset(-16)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-8)
            $0.bottom.equalTo(titleLabel)
        }
    }
    
    func configure(with exerciseGuide: Result) {
        let urlString = "\(exerciseGuide.img_file_url)\(exerciseGuide.img_file_nm)"
        let url = URL(string: urlString)
        thumbnailImageView.kf.setImage(with: url)
        
        videoLength.text = secondToMinute(exerciseGuide.vdo_len)
        titleLabel.text = exerciseGuide.trng_nm
    }
    
    func secondToMinute(_ second: String) -> String {
        let totalSecond = Int(second) ?? 0
        
        let minute = totalSecond / 60
        let second = totalSecond % 60
        
        return "\(minute):\(second)"
    }
}
