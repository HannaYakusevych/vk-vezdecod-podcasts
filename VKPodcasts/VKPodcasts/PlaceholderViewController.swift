//
//  PlaceholderViewController.swift
//  VKDonations
//
//  Created by Анна Якусевич on 12.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit

final class PlaceholderViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = """
        Заглушка
        Экран не реализован
        """
        
        view.backgroundColor = .backgroundContent
        view.addSubview(label)
        label.snp.makeConstraints { $0.center.equalToSuperview() }
        
        let button = UIButton()
        button.backgroundColor = .buttonPrimaryBackground
        button.layer.cornerRadius = 10
        button.setTitle("Закрыть", for: .normal)
        view.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(label.snp.bottom).offset(12)
            maker.height.equalTo(44)
            maker.width.equalTo(128)
        }
        button.enableTapping { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
