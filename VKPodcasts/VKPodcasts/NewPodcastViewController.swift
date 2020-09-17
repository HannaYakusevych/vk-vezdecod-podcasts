//
//  NewPodcastViewController.swift
//  VKPodcasts
//
//  Created by Анна Якусевич on 16.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit
import SnapKit
import TPKeyboardAvoiding
import MediaPlayer

final class NewPodcastViewController: UIViewController {
    
    private let imagePicker = UIImagePickerController()
    private let elementBuilder = ElementBuilder()
    
    private var audioUrl: URL?
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "gallery"))
        view.contentMode = .center
        view.backgroundColor = .fieldBackground
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.separatorAlpha?.cgColor
        view.enableTapping {
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .photoLibrary
            
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        return view
    }()
    
    private lazy var titleContainerView = makeTitleView()
    
    private lazy var titleView: InputView = {
        let view = InputView()
        view.setup(title: .title, placeholder: .titlePlaceholder, isEditable: true, needsVerticalInsets: false, height: 72)
        return view
    }()
    
    private lazy var descriptionView: InputView = {
        let view = InputView()
        view.setup(title: .description, isEditable: true, linesCount: 2)
        return view
    }()
    
    private lazy var newPodcastView = AddPodcastView(with: .placeholder, delegate: self)
//    private lazy var newPodcastView = AddPodcastView(with: .chosen(fileName: "My_podcast.mp3", length: "59:16"), delegate: self)
    
    private lazy var adultContentView = CheckpointView(with: "Ненормативный контент")
    private lazy var removeFromExportView = CheckpointView(with: "Исключить эпизод из экспорта")
    private lazy var podcastTrailerView = CheckpointView(with: "Трейлер подкаста")
    
    private lazy var availabilityView: UIView = {
        let view = UIView()
        
        let title = UILabel()
        title.text = "Кому доступен данный подкаст"
        title.textColor = .textPrimary
        title.font = .systemFont(ofSize: 17, weight: .regular)
        view.addSubview(title)
        title.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(4)
            maker.leading.equalToSuperview().offset(12)
        }
        
        let subtitle = UILabel()
        subtitle.text = "Всем пользователям"
        subtitle.textColor = .textSecondary
        subtitle.font = .systemFont(ofSize: 11, weight: .regular)
        view.addSubview(subtitle)
        subtitle.snp.makeConstraints { maker in
            maker.top.equalTo(title.snp.bottom).offset(4)
            maker.leading.equalToSuperview().offset(12)
            maker.bottom.equalToSuperview().offset(-12)
            maker.trailing.equalTo(title.snp.trailing)
        }
        
        let image = UIImageView(image: UIImage(named: "right_arrow"))
        image.contentMode = .center
        view.addSubview(image)
        image.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(12)
            maker.bottom.equalToSuperview().offset(-12)
            maker.trailing.equalToSuperview().offset(-16)
            maker.leading.greaterThanOrEqualTo(title.snp.trailing).offset(8)
        }
        
        view.enableTapping { [weak self] in
            let view = PlaceholderViewController()
            self?.present(view, animated: true, completion: nil)
        }
        return view
    }()
    
    private lazy var continueButton: UIButton = {
        let button = elementBuilder.continueButton()
        button.setTitle(.continueButton, for: .normal)
        button.enableTapping(continueCreation)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        imagePicker.delegate = self
    }

    func continueCreation() {
        // TODO: Implement
        let view = PlaceholderViewController()
        present(view, animated: true, completion: nil)
    }
}

extension NewPodcastViewController: AddPodcastViewDelegate {
    func uploadAudio() {
        let documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: ["public.audio"], in: .import)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    func editAudio() {
        // TODO: Open edit screen
        let view = PlaceholderViewController()
        present(view, animated: true, completion: nil)
    }
}

extension NewPodcastViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.image = pickedImage
            UIView.animate(withDuration: 0.3) {
                self.imageView.alpha = 1
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension NewPodcastViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
           return
        }
        
        audioUrl = myURL
        
        let asset = AVURLAsset(url: myURL, options: nil)
        let audioDurationSeconds = CMTimeGetSeconds(asset.duration)
        
        newPodcastView.setType(.chosen(fileName: String(myURL.relativeString.split(separator: "/").last ?? ""), length: timeFromSeconds(Int(audioDurationSeconds))))
    }
}

private extension NewPodcastViewController {
    func setupUI() {
        title = .newPodcast
        view.backgroundColor = .backgroundContent
        
        edgesForExtendedLayout = []
        navigationController?.navigationBar.tintColor = .headerTint
        
        // For the next screen
        let item = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
        item.tintColor = .headerTint
        navigationItem.backBarButtonItem = item
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.shadowColor = .separatorCommon
            navBarAppearance.backgroundColor = .headerBackground

            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            navigationController?.navigationBar.shadowImage = UIImage(color: UIColor.separatorCommon!)
            navigationController?.navigationBar.backgroundColor = .headerBackground
        }
        
        addContentView()
    }
    
    func addContentView() {
        let contentScrollView = TPKeyboardAvoidingScrollView()
        view.addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints { $0.edges.equalToSuperview(); $0.width.equalToSuperview() }
        
        let contentView = UIView()
        contentScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { $0.edges.equalToSuperview(); $0.width.equalToSuperview() }
        
        contentView.addSubview(titleContainerView)
        titleContainerView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(14)
            maker.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(descriptionView)
        descriptionView.snp.makeConstraints { maker in
            maker.top.equalTo(titleContainerView.snp.bottom).offset(14)
            maker.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(newPodcastView)
        newPodcastView.snp.makeConstraints { maker in
            maker.top.equalTo(descriptionView.snp.bottom)
            maker.leading.trailing.equalToSuperview()
        }
        
        let separatorView = UIView()
        separatorView.backgroundColor = .separatorCommon
        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints { maker in
            maker.top.equalTo(newPodcastView.snp.bottom)
            maker.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
            maker.height.equalTo(0.5)
        }
        
        contentView.addSubview(adultContentView)
        adultContentView.snp.makeConstraints { maker in
            maker.top.equalTo(separatorView.snp.bottom)
            maker.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(removeFromExportView)
        removeFromExportView.snp.makeConstraints { maker in
            maker.top.equalTo(adultContentView.snp.bottom)
            maker.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(podcastTrailerView)
        podcastTrailerView.snp.makeConstraints { maker in
            maker.top.equalTo(removeFromExportView.snp.bottom)
            maker.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(availabilityView)
        availabilityView.snp.makeConstraints { maker in
            maker.top.equalTo(podcastTrailerView.snp.bottom).offset(14.5)
            maker.leading.trailing.equalToSuperview()
        }
        
        let descriptionLabel = elementBuilder.descriptionLabel()
        descriptionLabel.text = "При публикации записи с эпизодом, он становится доступным для всех пользователей"
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { maker in
            maker.top.equalTo(availabilityView.snp.bottom).offset(4)
            maker.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
        }
        
        contentView.addSubview(continueButton)
        continueButton.snp.makeConstraints { maker in
            maker.top.equalTo(descriptionLabel.snp.bottom).offset(36)
            maker.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
            maker.bottom.equalToSuperview().offset(-12)
        }
    }
    
    func makeTitleView() -> UIView {
        let view = UIView()
        view.snp.makeConstraints { $0.height.equalTo(74) }
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(1)
            maker.bottom.equalToSuperview().offset(-1)
            maker.leading.equalToSuperview().offset(12)
            maker.width.equalTo(72)
        }
        
        view.addSubview(titleView)
        titleView.snp.makeConstraints { maker in
            maker.leading.equalTo(imageView.snp.trailing)
            maker.trailing.equalToSuperview()
            maker.top.equalToSuperview().offset(1)
            maker.bottom.equalToSuperview().offset(-1)
        }
        
        return view
    }
}
