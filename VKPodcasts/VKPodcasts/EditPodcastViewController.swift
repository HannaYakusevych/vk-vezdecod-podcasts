//
//  EditPodcastViewController.swift
//  VKPodcasts
//
//  Created by Анна Якусевич on 17.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit
import SnapKit

class EditPodcastViewController: UIViewController {
    
    private let elementBuilder = ElementBuilder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension EditPodcastViewController {
    func setupUI() {
        view.backgroundColor = .backgroundContent
        title = "Редактирование"
        edgesForExtendedLayout = []
        
        addContentView()
    }
    
    func addContentView() {
        let imageView = UIImageView(image: UIImage(named: "waveform"))
        view.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(50)
            maker.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
        }
        
        let buttonsView = UIView()
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.separatorAlpha?.cgColor
        view.addSubview(buttonsView)
        buttonsView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
            maker.top.equalTo(imageView.snp.bottom)
            maker.height.equalTo(60)
        }
    }
}
