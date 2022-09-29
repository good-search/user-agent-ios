//
//  DefaultBrowserHintViewController.swift
//  GOOD
//
//  Created by Shahen on 29.09.22.
//  Copyright © 2022 Cliqz. All rights reserved.
//

import UIKit
import Shared

protocol DefaultBrowserHintViewControllerDelegate: AnyObject {
    func defaultBrowserHintViewControllerDidFinish(_ viewController: UIViewController)
}

struct DefaultBrowserHintUX {
    static let ButtonHeight = 60.0
    static let ButtonBottomOffset = 20.0
    static let Padding = 10.0
    static let LogoImageSize = 45.0
    static let ImageTopOffes = 40.0
    static let CornerRadius = 10.0
    static let TextHorizontalPadding = 40.0
    static let TextVerticalPadding = 33.0
}

class DefaultBrowserHintViewController: UIViewController {

    weak var delegate: DefaultBrowserHintViewControllerDelegate?

    lazy private var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .White
        button.setTitle(Strings.General.CloseString, for: .normal)
        button.setTitleColor(UIColor.Brand, for: .normal)
        button.addTarget(self, action: #selector(closeButtonAction), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = DefaultBrowserHintUX.CornerRadius
        return button
    }()

    lazy private var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .White
        view.layer.cornerRadius = DefaultBrowserHintUX.CornerRadius
        return view
    }()

    lazy private var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "defaultFavicon"))
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = DefaultBrowserHintUX.CornerRadius / 2
        return imageView
    }()

    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = String(format: Strings.DefaultBrowserHint.Title, AppInfo.displayName)
        return label
    }()

    lazy private var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .ultraLight)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = String(format: Strings.DefaultBrowserHint.Message, AppInfo.displayName)
        return label
    }()

    lazy private var firstStepLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        label.textAlignment = .left
        label.text = Strings.DefaultBrowserHint.Step1
        return label
    }()

    lazy private var secondStepLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        label.textAlignment = .left
        label.text = Strings.DefaultBrowserHint.Step2
        return label
    }()

    lazy private var thirdStepLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        label.textAlignment = .left
        label.text = String(format: Strings.DefaultBrowserHint.Step3, AppInfo.displayName)
        return label
    }()

    lazy private var settingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.Brand
        button.setTitle(Strings.DefaultBrowserHint.Setting, for: .normal)
        button.setTitleColor(.White, for: .normal)
        button.addTarget(self, action: #selector(settingButtonAction), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = DefaultBrowserHintUX.CornerRadius
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture(gesture:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        self.view.backgroundColor = .black.withAlphaComponent(0.5)

        self.view.addSubview(self.closeButton)

        self.closeButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-DefaultBrowserHintUX.ButtonBottomOffset)
            make.height.equalTo(DefaultBrowserHintUX.ButtonHeight)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(DefaultBrowserHintUX.Padding)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-DefaultBrowserHintUX.Padding)
        }

        self.view.addSubview(self.contentView)

        self.contentView.snp.makeConstraints { make in
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(DefaultBrowserHintUX.Padding)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-DefaultBrowserHintUX.Padding)
            make.bottom.equalTo(self.closeButton.snp.top).offset(-DefaultBrowserHintUX.Padding)
            make.top.greaterThanOrEqualTo(self.view.safeAreaLayoutGuide.snp.top)
        }

        self.contentView.addSubview(self.logoImageView)
        self.logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.top.equalTo(self.contentView.snp.top).offset(DefaultBrowserHintUX.ImageTopOffes)
            make.height.width.equalTo(DefaultBrowserHintUX.LogoImageSize)
        }

        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.logoImageView.snp.bottom).offset(DefaultBrowserHintUX.TextVerticalPadding)
            make.leading.equalTo(self.contentView.snp.leading).offset(DefaultBrowserHintUX.TextHorizontalPadding)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-DefaultBrowserHintUX.TextHorizontalPadding)
        }

        self.contentView.addSubview(self.messageLabel)
        self.messageLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(DefaultBrowserHintUX.TextVerticalPadding)
            make.leading.equalTo(self.contentView.snp.leading).offset(DefaultBrowserHintUX.TextHorizontalPadding)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-DefaultBrowserHintUX.TextHorizontalPadding)
        }

        self.contentView.addSubview(self.firstStepLabel)
        self.firstStepLabel.snp.makeConstraints { make in
            make.top.equalTo(self.messageLabel.snp.bottom).offset(DefaultBrowserHintUX.TextVerticalPadding)
            make.leading.equalTo(self.contentView.snp.leading).offset(DefaultBrowserHintUX.TextHorizontalPadding)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-DefaultBrowserHintUX.TextHorizontalPadding)
        }

        self.contentView.addSubview(self.secondStepLabel)
        self.secondStepLabel.snp.makeConstraints { make in
            make.top.equalTo(self.firstStepLabel.snp.bottom).offset(DefaultBrowserHintUX.Padding / 2)
            make.leading.equalTo(self.contentView.snp.leading).offset(DefaultBrowserHintUX.TextHorizontalPadding)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-DefaultBrowserHintUX.TextHorizontalPadding)
        }

        self.contentView.addSubview(self.thirdStepLabel)
        self.thirdStepLabel.snp.makeConstraints { make in
            make.top.equalTo(self.secondStepLabel.snp.bottom).offset(DefaultBrowserHintUX.Padding / 2)
            make.leading.equalTo(self.contentView.snp.leading).offset(DefaultBrowserHintUX.TextHorizontalPadding)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-DefaultBrowserHintUX.TextHorizontalPadding)
        }

        self.contentView.addSubview(self.settingButton)
        self.settingButton.snp.makeConstraints { make in
            make.height.equalTo(DefaultBrowserHintUX.ButtonHeight)
            make.top.equalTo(self.thirdStepLabel.snp.bottom).offset(DefaultBrowserHintUX.TextVerticalPadding)
            make.leading.equalTo(self.contentView.snp.leading).offset(2 * DefaultBrowserHintUX.Padding)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-2 * DefaultBrowserHintUX.Padding)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-DefaultBrowserHintUX.ButtonBottomOffset)
        }
    }

    // MARK: - Actions

    @objc func tapGesture(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self.view)
        if !self.contentView.frame.contains(location) && !self.closeButton.frame.contains(location) {
            self.delegate?.defaultBrowserHintViewControllerDidFinish(self)
        }
    }

    @objc func closeButtonAction() {
        self.delegate?.defaultBrowserHintViewControllerDidFinish(self)
    }

    @objc func settingButtonAction() {
        self.delegate?.defaultBrowserHintViewControllerDidFinish(self)
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:])
    }

}
