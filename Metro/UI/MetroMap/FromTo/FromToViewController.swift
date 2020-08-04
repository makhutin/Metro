//
//  FromToViewController.swift
//  Metro
//
//  Created by Алексей Махутин on 28.07.2020.
//  Copyright © 2020 Mahutin Aleksei. All rights reserved.
//

import UIKit

internal enum FromToButtonType: Int {
    case from
    case to
}

internal protocol FromToViewControllerDelegate: AnyObject {
    func fromToViewController(_ fromToViewController: FromToViewController, didTapButton: FromToButtonType, stationID: Int)
    func fromToViewControllerWillCancel(_ fromToViewController: FromToViewController)
}

internal class FromToViewController: UIViewController {
    private enum Constants {
        static let stackViewHeight: CGFloat = 50
        static let stackViewInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        static let labelInsets = UIEdgeInsets(top: 30, left: 20, bottom: 20, right: 20)
        static let labelHight: CGFloat = 50
        static let dragViewHeight: CGFloat = 5
    }

    var presenter: FromToPressenterProtocol?
    weak var delegate: FromToViewControllerDelegate?
    private let transition: FromToTransition

    private var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()

    private var stationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        label.textColor = .getColor(.fromToViewController_buttonText)
        return label
    }()

    private var dragView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        self.transition = FromToTransition()
        super.init(nibName: nil, bundle: nil)
        self.transitioningDelegate = self.transition
        self.modalPresentationStyle = .custom
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateColor()

        self.view.addSubview(self.buttonsStackView)
        self.view.addSubview(self.numberLabel)
        self.view.addSubview(self.stationLabel)
        self.view.addSubview(self.dragView)
        self.createButtons()
        self.setupConstraints()

        self.numberLabel.text = " \(String.getCap(.fromToViewController_line))-\(self.presenter?.info?.lineNumber ?? 0) "
        self.stationLabel.text = self.presenter?.info?.name.capitalized

        self.updatePreferredContentSize()
    }

    private func createButtons() {
        [String.getCap(.fromToViewController_from), String.getCap(.fromToViewController_to)].enumerated().forEach { elem in
            let button = UIButton()
            button.setTitle(elem.element, for: .normal)
            button.setTitleColor(.getColor(.fromToViewController_buttonText), for: .normal)
            button.addTarget(self, action: #selector(buttonHandler(_:)), for: .touchUpInside)
            button.tag = elem.offset
            button.backgroundColor = .getColor(.fromToViewController_buttonBackground)
            button.clipsToBounds = true
            self.buttonsStackView.addArrangedSubview(button)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.dragView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (Constants.labelInsets.top - Constants.dragViewHeight) / 2),
            self.dragView.heightAnchor.constraint(equalToConstant: Constants.dragViewHeight),
            self.dragView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2),
            self.dragView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            self.numberLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Constants.labelInsets.top),
            self.numberLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.labelInsets.left),
            self.numberLabel.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight),

            self.stationLabel.topAnchor.constraint(equalTo: self.numberLabel.topAnchor),
            self.stationLabel.leadingAnchor.constraint(equalTo: self.numberLabel.trailingAnchor, constant: Constants.labelInsets.left),
            self.stationLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constants.labelInsets.right),
            self.stationLabel.heightAnchor.constraint(equalTo: self.numberLabel.heightAnchor),

            self.buttonsStackView.topAnchor.constraint(equalTo: self.numberLabel.bottomAnchor, constant: Constants.stackViewInsets.top),
            self.buttonsStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.stackViewInsets.left),
            self.buttonsStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constants.stackViewInsets.right),
            self.buttonsStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.stackViewInsets.bottom)
        ])
        self.stationLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
    }

    private func updatePreferredContentSize() {
        let height = Constants.labelInsets.top
            + Constants.labelHight
            + Constants.stackViewInsets.top
            + Constants.stackViewHeight
            + Constants.stackViewInsets.bottom

        self.preferredContentSize = CGSize(width: self.view.bounds.width,
                                           height: height)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.buttonsStackView.arrangedSubviews.forEach { button in
            button.layer.cornerRadius = 10
        }
        self.numberLabel.backgroundColor = self.presenter?.info?.color
        self.numberLabel.layer.cornerRadius = 10
        self.dragView.layer.cornerRadius = self.dragView.frame.height / 2
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard #available(iOS 13.0, *) else { return }

        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            self.updateColor()
        }
    }

    private func updateColor() {
        self.view.backgroundColor = .getColor(.fromToViewController_background)
        self.stationLabel.textColor = .getColor(.fromToViewController_mainText)
        self.dragView.backgroundColor = .getColor(.fromToViewController_dragView)
    }

    @objc private func buttonHandler(_ sender: UIButton) {
        guard let type = FromToButtonType(rawValue: sender.tag),
            let stationID = self.presenter?.info?.id else { return }

        self.delegate?.fromToViewController(self, didTapButton: type, stationID: stationID)
        self.dismiss(animated: true, completion: nil)
    }
}

extension FromToViewController: FromToDrivenDelegate {
    func fromToDrivenDidFinishInteractive(_ fromToDriven: FromToDriven) {
        self.delegate?.fromToViewControllerWillCancel(self)
    }
}
