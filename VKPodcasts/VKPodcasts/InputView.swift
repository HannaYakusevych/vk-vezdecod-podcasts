//
//  InputView.swift
//  VKDonations
//
//  Created by Анна Якусевич on 12.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit

final class InputView: UIView {
    
    enum InputType {
        case int
        case string
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        titleLabel.textColor = .textSubhead
        return titleLabel
    }()
    
    private lazy var textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .fieldBackground
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.33
        view.layer.borderColor = UIColor.fieldBorder?.cgColor
        view.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        view.textColor = .textPrimary
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.delegate = self
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private var defaultPlaceholder: String?
    private var placeholder: String?
    private var inputType: InputType = .string
    
    func setup(title: String, placeholder: String? = "", default: String? = nil, isEditable: Bool, linesCount: Int = 1, inputType: InputType = .string, needsVerticalInsets: Bool = true, height: CGFloat = 96) {
        titleLabel.text = title
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(needsVerticalInsets ? 12 : 1)
            maker.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
        }
        
        addSubview(textView)
        defaultPlaceholder = placeholder
        textView.text = placeholder
        textView.textColor = .textPlaceholder
        textView.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom).offset(8)
            maker.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
            maker.bottom.equalToSuperview().offset(needsVerticalInsets ? -12 : -1)
        }
        
        snp.makeConstraints { $0.height.equalTo(linesCount == 1 ? height : 116) }
        
        self.inputType = inputType
    }
    
    func validate() -> Bool {
        if textView.text.isEmpty || (inputType == .int && !textView.text.isNumeric) {
            textView.layer.borderColor = UIColor.fieldErrorBorder?.cgColor
            return false
        }
        return true
    }
    
    func getText() -> String {
        return textView.text
    }
}

extension InputView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == defaultPlaceholder {
            textView.text = ""
            textView.textColor = .textPrimary
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = defaultPlaceholder
            textView.textColor = UIColor.textPlaceholder
            placeholder = ""
        } else {
            placeholder = textView.text
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholder = textView.text
        if (inputType == .int && !textView.text.isEmpty && !textView.text.isNumeric) || textView.text.isEmpty {
            textView.layer.borderColor = UIColor.fieldErrorBorder?.cgColor
        } else {
            textView.layer.borderColor = UIColor.fieldBorder?.cgColor
        }
    }
}
