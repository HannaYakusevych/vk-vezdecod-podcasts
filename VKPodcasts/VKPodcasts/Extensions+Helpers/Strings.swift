//
//  Strings.swift
//  VKDonations
//
//  Created by Анна Якусевич on 11.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import Foundation

extension String {
    // First screen
    static let addFirstPodcastTitle = "Добавьте первый подкаст"
    static let addFirstPodcastDescription = "Добавляйте, редактируйте и делитесь подкастами вашего сообщества."
    static let addFirstPodcastButton = "Добавить подкаст"
    
    // New Podcast screen
    static let newPodcast = "Новый подкаст"
    static let title = "Название"
    static let titlePlaceholder = "Введите название подкаста"
    static let description = "Описание подкаста"
    static let uploadPodcastTitle = "Загрузите Ваш подкаст"
    static let uploadPodcastDescription = "Выберите готовый аудиофайл з вашего телефона и добавьте его"
    static let uploadPodcastButton = "Загрузить файл"
    static let editHint = "Вы можете добавить таймкоды и скорректировать подкаст в режиме редактирования"
    static let editButton = "Редактировать аудиозапись"
    static let continueButton = "Далее"
}

extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}

func timeFromSeconds(_ seconds: Int) -> String {
    var time = ""
    let hours = Int(seconds / 3600)
    let minutes = Int((seconds % 3600) / 60)
    let seconds = seconds % 60
    
    if hours != 0 {
        time += "\(hours):"
    }
    time += minutes < 10 ? "0\(minutes):" : "\(minutes):"
    time += seconds < 10 ? "0\(seconds)" : "\(seconds)"
    return time
}
