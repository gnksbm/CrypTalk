//
//  PostDetailViewController.swift
//  Coin
//
//  Created by gnksbm on 8/29/24.
//

import UIKit

import CoinFoundation
import Domain

import Neat
import SnapKit

final class PostDetailViewController: BaseViewController, ViewType {
    private lazy var textViewHeight = textViewFont.lineHeight
    + commentTextView.layoutMargins.top
    + commentTextView.layoutMargins.bottom
    private let textViewFont = UIFont.systemFont(
        ofSize: 18,
        weight: .medium
    )
    private lazy var textViewPlaceholder = NSAttributedString(
        string: "의견을 남겨보세요",
        attributes: [
            .font: textViewFont,
            .foregroundColor: UIColor.tertiaryLabel
        ]
    )
    
    private let headerView = PostDetailHeaderView()
    private lazy var tableView = PostDetailTableView().nt.configure {
        $0.tableHeaderView(headerView)
    }
    private lazy var commentTextView = UITextView().nt.configure {
        $0.attributedText(textViewPlaceholder)
            .backgroundColor(.clear)
            .delegate(self)
    }
    private let commentBackgroundView = UIView().nt.configure {
        $0.layer.cornerRadius(Design.Radius.regular)
            .backgroundColor(.tertiarySystemFill)
    }
    private lazy var commentDoneButton = UIButton(
        configuration: .plain()
    ).nt.configure {
        $0.configuration.image(Design.ImageLiteral.sendComment)
            .configuration.preferredSymbolConfigurationForImage(
                UIImage.SymbolConfiguration(pointSize: 20)
            )
            .configurationUpdateHandler(
                { button in
                    button.tintColor = button.isEnabled ?
                        .secondaryLabel : .tertiaryLabel
                }
            )
            .isEnabled(false)
    }
    
    init(viewModel: PostDetailViewModel) {
        super.init()
        self.viewModel = viewModel
        configureCommentTextView()
    }
    
    func bind(viewModel: PostDetailViewModel) {
        let output = viewModel.transform(
            input: PostDetailViewModel.Input(
                viewWillAppear: viewWillAppearEvent,
                commentChangeEvent: commentTextView.rx.text.orEmpty
                    .asObservable(),
                commentDoneButtonTapEvent: commentDoneButton.rx.tap
                    .asObservable()
            ),
            disposeBag: &disposeBag
        )
        
        disposeBag.insert {
            output.post
                .withUnretained(self)
                .bind { vc, item in
                    vc.headerView.updateView(item: item)
                    vc.tableView.updateItems(item.comments)
                }
        }
    }
    
    override func configureLayout() {
        [tableView, commentBackgroundView].forEach { view.addSubview($0) }
        [commentTextView, commentDoneButton].forEach { view.addSubview($0) }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.snp.makeConstraints { make in
            make.width.equalTo(tableView)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeArea)
            make.bottom.equalTo(commentBackgroundView.snp.top)
                .offset(Design.Padding.regular)
        }
        
        commentBackgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeArea)
                .inset(Design.Padding.regular)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
                .offset(-Design.Padding.regular)
        }
        
        commentTextView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(commentBackgroundView)
                .inset(Design.Padding.small)
            make.leading.equalTo(commentBackgroundView)
                .inset(Design.Padding.regular)
            make.trailing.equalTo(commentDoneButton.snp.leading)
                .offset(-Design.Padding.small)
            make.height.equalTo(textViewHeight)
        }
        
        commentDoneButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(commentBackgroundView)
                .inset(Design.Padding.small)
        }
    }
    
    private func configureCommentTextView() {
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        tapGesture.rx.event
            .withUnretained(self)
            .bind { vc, _ in
                vc.commentTextView.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        tableView.keyboardDismissMode = .interactive
    }
}

extension PostDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.contentSize.height < textViewFont.lineHeight * 4 {
            commentTextView.snp.updateConstraints { make in
                make.height.equalTo(textView.contentSize.height)
            }
        }
        commentDoneButton.isEnabled = !(textView.text.isEmpty ||
        textView.attributedText == textViewPlaceholder)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.attributedText == textViewPlaceholder {
            textView.text.removeAll()
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty == true {
            textView.attributedText = textViewPlaceholder
        }
    }
}
