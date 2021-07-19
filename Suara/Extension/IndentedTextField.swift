//
//  IndentedTextField.swift
//  Suara
//
//  Created by Muhammad Noor on 17/07/21.
//

import UIKit

@objc protocol IndentedTextFieldDelegate{
	@objc func imageTapped()
	@objc func rightViewItem() -> UIView
}

class IndentedTextField: UITextField {

	let padding: CGFloat
	var delegateIndented : IndentedTextFieldDelegate?
	let prefix: String?
		var value: String {
				get {
						guard let text = text else { return "" }
						if let prefix = prefix {
								return String(text.dropFirst(prefix.count))
						}
						return text
				}
				set {
						if let prefix = prefix {
								text = prefix + newValue
								return
						}
						text = newValue
				}
		}
		var onBeginEditing: (String) -> Void = {_ in}
		var onEditing: (String) -> Void = {_ in}
		var onEndEditing: (String) -> Void = {_ in}

	public init(placeholder: String? = nil, padding: CGFloat = 0, cornerRadius: CGFloat = 0, keyboardType: UIKeyboardType = .default, backgroundColor: UIColor = .clear, isSecureTextEntry: Bool = false, borderWidth: CGFloat = 0, borderColor: UIColor = .gray, prefix: String? = nil) {
		self.padding = padding
		self.prefix = prefix
		super.init(frame: .zero)
		layer.cornerRadius = cornerRadius
		self.backgroundColor = backgroundColor
		self.keyboardType = keyboardType
		self.isSecureTextEntry = isSecureTextEntry
		self.layer.borderWidth = borderWidth
		self.layer.borderColor = borderColor.cgColor
		self.font =  .Roboto(.medium, size: 12)
		self.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.font : UIFont.Roboto(.regular, size: 12), NSAttributedString.Key.foregroundColor: UIColor.gray])
				text = prefix
				delegate = self
	}
	@objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
	{
		delegateIndented?.imageTapped()
		// Your action
	}

	func reload() {
		self.rightViewMode = UITextField.ViewMode.always
		let rightView = delegateIndented?.rightViewItem() ?? UIView()
		let view = UIView(frame: CGRect(
			x: 0, y: 0, // keep this as 0, 0
			width: rightView.frame.width + padding, // add the padding
			height: rightView.frame.height))
		view.addSubview(rightView)

		self.rightView = view
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		self.rightView?.isUserInteractionEnabled = true
		self.rightView?.addGestureRecognizer(tapGestureRecognizer)

	}


	override open func textRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: padding, dy: padding)
	}

	override open func editingRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: padding, dy: padding)
	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

extension IndentedTextField: UITextFieldDelegate {
		func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
				guard let prefix = prefix else { return true }
				if range.location >= prefix.count {
						onEditing(textField.text ?? "")
						return true
				}
				return false
		}

		func textFieldDidBeginEditing(_ textField: UITextField) {
				onBeginEditing(textField.text ?? "")
		}

		func textFieldDidEndEditing(_ textField: UITextField) {
				onEndEditing(textField.text ?? "")
		}
}

@objc protocol CustomIndentedTextFieldDelegate{
		@objc func imageTapped()
		@objc func rightViewItem() -> UIView
}

class CustomIndentedTextFieldWithButton: UITextField {
		
		let padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
		
		override open func textRect(forBounds bounds: CGRect) -> CGRect {
				return bounds.inset(by: padding)
		}
		
		override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
				return bounds.inset(by: padding)
		}
		
		override open func editingRect(forBounds bounds: CGRect) -> CGRect {
				return bounds.inset(by: padding)
		}
		
}

