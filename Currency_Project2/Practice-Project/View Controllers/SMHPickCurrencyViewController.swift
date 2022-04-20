//
//  SMHPickCurrencyViewController.swift
//  Practice-Project
//
//  Created by Jaqueline Sanchez-Macias on 4/16/22.
//

import UIKit

class SMHPickCurrencyViewController: UIViewController {
    
    @IBOutlet var topPickerContainer: UIView!
    @IBOutlet var topPickerContainerHeightConstraint: NSLayoutConstraint!
    var topPickerContainerWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet var pickersStackView: UIStackView!
    @IBOutlet var bottomPickerView: UIPickerView!
    @IBOutlet var topPickerView: UIPickerView!
    
    let presenter = SMHPickerPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter.view = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.updateUIBasedOnInterfaceOrientation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let rows = presenter.getInitialSelections()
        
        topPickerView.selectRow(rows.0, inComponent: 0, animated: false)
        bottomPickerView.selectRow(rows.1, inComponent: 0, animated: false)
    }
    
    func setupUI() {
        self.bottomPickerView.delegate = self
        self.bottomPickerView.dataSource = self
        
        self.topPickerView.delegate = self
        self.topPickerView.delegate = self
        
        self.initLandscapeConstraints()
    }
}


extension SMHPickCurrencyViewController {
    @IBAction func didClickOnConfirm() {
        presenter.handleConfirmClicked()
    }
}


extension SMHPickCurrencyViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Currencies.all.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Currencies.all[row]
    }
}

// MARK: - Landscape Support
extension SMHPickCurrencyViewController {
    
    func initLandscapeConstraints() {
        self.topPickerContainerWidthConstraint = NSLayoutConstraint(item: self.topPickerContainer!, attribute: .width, relatedBy: .equal, toItem: self.pickersStackView!, attribute: .width, multiplier: 0.5, constant: 0)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        coordinator.animate { [weak self] context in
            self?.updateUIBasedOnInterfaceOrientation()
        }
    }
    
    func updateUIBasedOnInterfaceOrientation() {
        if let inLandscape = self.inLandscapeMode(), inLandscape {
            self.toLandscapeLayout()
        } else {
            self.toPortraitLaytout()
        }
    }
    
    func toLandscapeLayout() {
        self.pickersStackView.axis = .horizontal
        
        self.updateOrientationConstraints(inPortrait: false)
        self.view.layoutIfNeeded()
    }
    
    func toPortraitLaytout() {
        self.pickersStackView.axis = .vertical
        
        self.updateOrientationConstraints(inPortrait: true)
        self.view.layoutIfNeeded()
    }
    
    func updateOrientationConstraints(inPortrait: Bool) {
        self.topPickerContainerHeightConstraint.isActive = inPortrait
        
        self.topPickerContainerWidthConstraint.isActive = !inPortrait
    }
}
