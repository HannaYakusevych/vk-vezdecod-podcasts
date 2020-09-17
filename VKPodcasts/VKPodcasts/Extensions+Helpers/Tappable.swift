//
//  Tappable.swift
//  VKDonations
//
//  Created by Анна Якусевич on 12.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import Foundation
import UIKit

protocol Tappable: AnyObject, RecognizerDeletable {
    func enableTapping(_ handler: @escaping () -> Void)
    func disableTapping()
}

extension Tappable where Self: UIView {
    func enableTapping(_ tapHandler: @escaping () -> Void) {
        isUserInteractionEnabled = true

        // Удаление cтарого recognizer'а
        disableTapping()

        let tapRecognizer = TapGestureRecognizer(tapHandler: tapHandler)
        addGestureRecognizer(tapRecognizer)
    }

    func disableTapping() {
        deleteRecognizer(recognizerClass: TapGestureRecognizer.self)
    }
}

protocol RecognizerDeletable {
    @discardableResult
    func deleteRecognizer<T>(recognizerClass: T.Type) -> Bool
}

extension RecognizerDeletable where Self: UIView {
    @discardableResult
    func deleteRecognizer<T>(recognizerClass _: T.Type) -> Bool {
        let recognizersToDelete = gestureRecognizers?.filter { $0 is T } ?? []
        recognizersToDelete.forEach(removeGestureRecognizer)

        return !recognizersToDelete.isEmpty
    }
}

final class TapGestureRecognizer: UITapGestureRecognizer {
    private let tapHandler: (() -> Void)?

    public required init(tapHandler: (() -> Void)?) {
        self.tapHandler = tapHandler
        super.init(target: nil, action: nil)
        addTarget(self, action: #selector(handleTap))
    }

    // MARK: - Tap handler

    @objc private func handleTap() {
        tapHandler?()
    }
}

extension UIView: Tappable { }
