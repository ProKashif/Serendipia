//
//  RegistrationController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/21/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit
import CountryPickerView
import AlamofireImage

class RegistrationController: UIViewController {
	@IBOutlet private weak var tableView: UITableView!
	private let dataSource = RegistrationField.allCases
	private let registrationForm = RegistrationForm()
	
	@objc
	private func saveProfile() {
		//DO SAVING STUFF
		dismiss(animated: true) {
			UserManager.shared.loggedInUser = TestUsers.jLo()
		}
	}
	
	func pickProfilePic() {
		let picker = UIImagePickerController()
		picker.allowsEditing = true
		picker.delegate = self
		present(picker, animated: true)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		startAvoidingKeyboard()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		stopAvoidingKeyboard()
	}
}


extension RegistrationController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSource.count + 1 // "save profile" button
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == tableView.numberOfRows(inSection: indexPath.section)-1 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "save", for: indexPath)
			if let button = cell.contentView.subviews.first(where: { $0.isKind(of: UIButton.self) }) as? UIButton {
				button.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
			}
			return cell
		}
		
		let registrationField = dataSource[indexPath.row]
		let cell: UITableViewCell
		switch registrationField {
		case .profilePic:
			cell = tableView.dequeueReusableCell(withIdentifier: "profilePic", for: indexPath)
			if let image = registrationForm.profilePic, let cell = cell as? ProfilePicCell {
				cell.setImage(image)
			}
		case .firstName, .lastName, .country:
			cell = tableView.dequeueReusableCell(withIdentifier: "name", for: indexPath)
			if let label = cell.contentView.viewWithTag(1) as? UILabel,
				let textField = cell.contentView.viewWithTag(2) as? RegistrationTextField {
				switch registrationField {
				case .firstName:
					label.text = "First Name"
					textField.placeholder = label.text
				case .lastName:
					label.text = "Last Name"
					textField.placeholder = label.text
				case .country:
					label.text = "Country"
					textField.text = registrationForm.value(forField: .country)
					textField.placeholder = "Select"
					textField.rightView = UIImageView(image: UIImage(named: "downChevron"))
					textField.tintColor = .clear
				default: break
				}
				textField.field = registrationField
			}
		case .dream, .passions, .achievements, .skills:
			cell = tableView.dequeueReusableCell(withIdentifier: "longInput", for: indexPath)
			if let label = cell.contentView.viewWithTag(1) as? UILabel,
				let textField = cell.contentView.viewWithTag(2) as? RegistrationTextField {
				switch registrationField {
				case .dream:
					label.text = "What's your dream?"
				case .passions:
					label.text = "What are your passions?"
				case .achievements:
					label.text = "Your biggest achievements"
				case .skills:
					label.text = "Your skills"
				default: break
				}
				textField.placeholder = label.text
				textField.field = registrationField
			}
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath == indexPathForProfilePicCell {
			pickProfilePic()
		}
	}
	
	private var indexPathForProfilePicCell: IndexPath? {
		guard let row = dataSource.firstIndex(of: .profilePic) else { return nil }
		return IndexPath(row: row, section: 0)
	}
}

extension RegistrationController: UITextFieldDelegate, CountryPickerViewDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard let textField = textField as? RegistrationTextField else { return true }
		if let cell = textField.owningTableViewCell,
			var index = tableView.indexPath(for: cell) {
			index.row += 1
			guard index.row < tableView.numberOfRows(inSection: 0) else {
				view.firstResponder?.endEditing(true)
				return false
			}
			if let nextCell = tableView.cellForRow(at: index),
				let textField = nextCell.contentView.viewWithTag(2) as? RegistrationTextField {
				textField.becomeFirstResponder()
			}
		}
		return false
	}
	
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		guard let textField = textField as? RegistrationTextField else { return true }
		if textField.field == .country {
			let countryPicker = CountryPickerView()
			countryPicker.showCountriesList(from: self)
			countryPicker.delegate = self
			return false
		}
		
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		guard
			let textField = textField as? RegistrationTextField,
			let text = textField.text,
			let field = textField.field
		else { return }
		registrationForm.setValue(text, forField: field)
	}
	
	func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
		registrationForm.setValue(country.name, forField: .country)
		if let row = RegistrationField.allCases.firstIndex(of: .country) {
			tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
		}
	}
}

class RegistrationTextField: UITextField {
	var field: RegistrationField?
}

class ProfilePicCell: UITableViewCell {
	@IBOutlet private weak var profileView: UIImageView?
	func setImage(_ image: UIImage) {
		profileView?.image = image
	}
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let image = info[.editedImage] as? UIImage else { return }
		
		registrationForm.profilePic = image
		if let indexPath = indexPathForProfilePicCell {
			tableView.reloadRows(at: [indexPath], with: .automatic)
		}
		dismiss()
	}
}

