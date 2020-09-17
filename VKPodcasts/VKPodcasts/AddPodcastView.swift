//
//  AddPodcastView.swift
//  VKPodcasts
//
//  Created by Анна Якусевич on 16.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit

protocol AddPodcastViewDelegate: class {
    func uploadAudio()
    func editAudio()
}

final class AddPodcastView: UIView {
    
    enum InputType {
        case placeholder
        case chosen(fileName: String, length: String)
    }
    
    private let elementBuilder = ElementBuilder()
    
    private lazy var placeholderView = makePlaceholderView()
    private lazy var contentView = makeContentView()
    
    private weak var delegate: AddPodcastViewDelegate?
    
    // Placeholder
    private lazy var titleLabel: UILabel = {
        let title = elementBuilder.titleLabel()
        title.text = .uploadPodcastTitle
        return title
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let subtitle = elementBuilder.subtitleLabel()
        subtitle.text = .uploadPodcastDescription
        return subtitle
    }()
    
    private lazy var button: UIButton = {
        let button = elementBuilder.additionalButton()
        button.setTitle(.uploadPodcastButton, for: .normal)
        return button
    }()
    
    private lazy var contentTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor = .textPrimary
        return titleLabel
    }()
    
    private lazy var timeLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        titleLabel.textColor = .textSecondary
        titleLabel.contentMode = .right
        return titleLabel
    }()
    
    init(with type: InputType, delegate: AddPodcastViewDelegate? = nil) {
        super.init(frame: .zero)
        
        addViews()
        setType(type)
        self.delegate = delegate
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func setType(_ type: InputType) {
        switch type {
        case .placeholder:
            placeholderView.isHidden = false
            contentView.isHidden = true
        case .chosen(let fileName, let length):
            placeholderView.isHidden = true
            contentView.isHidden = false
            contentTitleLabel.text = fileName
            timeLabel.text = length
        }
    }
    
    func addViews() {
        snp.makeConstraints { maker in
            maker.height.equalTo(196)
        }
        
        addSubview(placeholderView)
        placeholderView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        addSubview(contentView)
        contentView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func makePlaceholderView() -> UIView {
        let view = UIView()
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(32)
            maker.leading.equalToSuperview().offset(32)
            maker.trailing.equalToSuperview().offset(-32)
        }
        
        view.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom).offset(8)
            maker.leading.equalToSuperview().offset(32)
            maker.trailing.equalToSuperview().offset(-32)
        }
        
        view.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().offset(-32)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(36)
            maker.width.equalTo(148)
        }
        
        button.enableTapping { [weak self] in
            self?.delegate?.uploadAudio()
        }
        
        return view
    }
    
    func makeContentView() -> UIView {
        let view = UIView()
        
        let infoView = UIView()
        view.addSubview(infoView)
        infoView.snp.makeConstraints { maker in
            maker.height.equalTo(90)
            maker.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
            maker.top.equalToSuperview().offset(22)
        }
        
        let imageView = UIImageView(image: UIImage(named: "audio"))
        infoView.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.top.leading.equalToSuperview()
            maker.height.width.equalTo(48)
        }
        
        infoView.addSubview(contentTitleLabel)
        contentTitleLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(14)
            maker.leading.equalTo(imageView.snp.trailing).offset(12)
        }
        
        infoView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview()
            maker.top.equalToSuperview().offset(16)
            maker.leading.greaterThanOrEqualTo(contentTitleLabel.snp.trailing).offset(8)
        }
        
        let hintLabel = UILabel()
        hintLabel.font = .systemFont(ofSize: 13, weight: .regular)
        hintLabel.textColor = .textSecondary
        hintLabel.numberOfLines = 2
        hintLabel.text = .editHint
        infoView.addSubview(hintLabel)
        hintLabel.snp.makeConstraints { maker in
            maker.trailing.leading.bottom.equalToSuperview()
            maker.top.equalTo(imageView.snp.bottom).offset(10)
        }
        
        let button = elementBuilder.bigAdditionalButton()
        button.setTitle(.editButton, for: .normal)
        
        view.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().offset(-22)
            maker.height.equalTo(44)
            maker.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
        }
        
        button.enableTapping { [weak self] in
            self?.delegate?.editAudio()
        }
        return view
    }
}

