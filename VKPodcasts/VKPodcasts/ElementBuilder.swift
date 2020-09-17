//
//  ElementBuilder.swift
//  VKPodcasts
//
//  Created by Анна Якусевич on 17.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit

final class ElementBuilder {
    func titleLabel() -> UILabel {
        let title = UILabel()
        title.textColor = .textPrimary
        title.font = .systemFont(ofSize: 20, weight: .semibold)
        title.textAlignment = .center
        title.numberOfLines = 2
        return title
    }
    
    func subtitleLabel() -> UILabel {
        let subtitle = UILabel()
        subtitle.textColor = .textSecondary
        subtitle.font = .systemFont(ofSize: 16, weight: .regular)
        subtitle.textAlignment = .center
        subtitle.numberOfLines = 2
        return subtitle
    }
    
    func descriptionLabel() -> UILabel {
        let subtitle = UILabel()
        subtitle.textColor = .textSecondary
        subtitle.font = .systemFont(ofSize: 13, weight: .regular)
        subtitle.textAlignment = .left
        subtitle.numberOfLines = 2
        return subtitle
    }
    
    func standardButton() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .buttonPrimaryBackground
        button.layer.cornerRadius = 10
        button.tintColor = .buttonPrimaryForeground
        button.setTitleColor(.buttonPrimaryForeground, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        return button
    }
    
    func additionalButton() -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.buttonOutlineBorder?.cgColor
        button.tintColor = .buttonOutlineForeground
        button.setTitleColor(.buttonOutlineForeground, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        return button
    }
    
    func bigAdditionalButton() -> UIButton {
        let button = additionalButton()
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        return button
    }
    
    func continueButton() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .buttonPrimaryBackground
        button.layer.cornerRadius = 10
        button.tintColor = .buttonPrimaryForeground
        button.setTitleColor(.buttonPrimaryForeground, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.snp.makeConstraints { maker in
            maker.height.equalTo(44)
        }
        return button
    }
}
