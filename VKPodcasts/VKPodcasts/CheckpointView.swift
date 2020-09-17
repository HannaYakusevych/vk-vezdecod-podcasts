//
//  CheckpointView.swift
//  VKPodcasts
//
//  Created by Анна Якусевич on 17.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit

final class CheckpointView: UIView {
    
    private lazy var checkpointImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "check_box_off"))
        view.contentMode = .center
        view.snp.makeConstraints { maker in
            maker.width.equalTo(44)
        }
        view.enableTapping { [weak view] in
            view?.image = UIImage(named: self.isOn ? "check_box_off" : "check_box_on")
            self.isOn.toggle()
        }
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .textPrimary
        return label
    }()
    
    private(set) var isOn = false
    
    init(with title: String) {
        super.init(frame: .zero)
        
        setupUI()
        titleLabel.text = title
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func setupUI() {
        snp.makeConstraints { maker in
            maker.height.equalTo(48)
        }
        
        addSubview(checkpointImageView)
        checkpointImageView.snp.makeConstraints { maker in
            maker.top.bottom.leading.equalToSuperview()
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview()
            maker.top.equalToSuperview().offset(14)
            maker.bottom.equalToSuperview().offset(-14)
            maker.leading.equalTo(checkpointImageView.snp.trailing)
        }
    }
}
