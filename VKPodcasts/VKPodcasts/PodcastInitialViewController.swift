//
//  PodcastInitialViewController.swift
//  VKPodcasts
//
//  Created by Анна Якусевич on 16.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit
import SnapKit

class PodcastInitialViewController: UIViewController {
    
    private let elementBuilder = ElementBuilder()
    
    private lazy var imageView = UIImageView(image: UIImage(named: "add_new"))
    private lazy var titleLabel: UILabel = {
        let title = elementBuilder.titleLabel()
        title.text = .addFirstPodcastTitle
        return title
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let subtitle = elementBuilder.subtitleLabel()
        subtitle.text = .addFirstPodcastDescription
        return subtitle
    }()
    
    private lazy var button: UIButton = {
        let button = elementBuilder.standardButton()
        button.setTitle(.addFirstPodcastButton, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

private extension PodcastInitialViewController {
    func setupUI() {
        view.backgroundColor = .backgroundContent
        
        navigationController?.navigationBar.tintColor = .headerTint
        
        // For the next screen
        let item = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
        item.tintColor = .headerTint
        navigationItem.backBarButtonItem = item
        
        addContentView()
    }
    
    func addContentView() {
        let contentView = UIView()
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { maker in
            maker.height.equalTo(296)
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(48)
            maker.height.width.equalTo(56)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(imageView.snp.bottom).offset(12)
            maker.leading.equalToSuperview().offset(32)
            maker.trailing.equalToSuperview().offset(-32)
        }
        
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom).offset(8)
            maker.leading.equalToSuperview().offset(32)
            maker.trailing.equalToSuperview().offset(-32)
        }
        
        contentView.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().offset(-48)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(36)
            maker.width.equalTo(166)
        }
        
        button.enableTapping { [weak self] in
            let vc = NewPodcastViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
