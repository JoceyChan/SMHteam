//
//  SMHMainViewController.swift
//  Practice-Project
//
//  Created by Jaqueline Sanchez-Macias on 4/14/22.
//

import UIKit
import QuartzCore

class SMHMainViewController: UIViewController {
    
    // MARK: - Constraint Related Outlets and Properties
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var topContainerView: UIView!
    @IBOutlet var bottomContainerView: UIView!
    @IBOutlet var keypadStackView: UIStackView!
    
    // Outlets to top three containers heights and widths
    @IBOutlet var portraitTopContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet var portraitBottomContainerHeightConstraint: NSLayoutConstraint!
    var landscapeTopContainerHeightConstraint: NSLayoutConstraint!
    var landscapeBottomContainerHeightConstraint: NSLayoutConstraint!
    
    // Outlets to top container views
    @IBOutlet var portraitEntriesContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet var currencyStackView: UIStackView!
    @IBOutlet var mainCurrencyContainer: UIView!
    var landscapeEntriesContainerHeightConstraint: NSLayoutConstraint!
    
    // Top Container Outlets
    @IBOutlet var topEntriesStackView: UIStackView!
    @IBOutlet var topFieldContainer: UIView!
    @IBOutlet var bottomFieldContainer: UIView!
    @IBOutlet var bottomFieldHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topFieldHeightConstraint: NSLayoutConstraint!
    @IBOutlet var arrowImageView: UIImageView!
    var bottomFieldWidthConstraint: NSLayoutConstraint!
    var topFieldWidthConstraint: NSLayoutConstraint!
    
    
    // MARK: - Main Outlets and Properties
    @IBOutlet var topCurrencyLabelContainer: UIView!
    @IBOutlet var bottomCurrencyLabelContainer: UIView!
    @IBOutlet var topCurrencyValueLabel: UILabel!
    @IBOutlet var topCurrencyCodeLabel: UILabel!
    @IBOutlet var bottomCurrencyValueLabel: UILabel!
    @IBOutlet var bottomCurrencyCodeLabel: UILabel!
    @IBOutlet var exchangeRateContainer: UIView!
    @IBOutlet var exchangeRateLeftLabel: UILabel!
    @IBOutlet var exchangeRateRightLabel: UILabel!
    
    let containerRadius = CGFloat(8.0)
    
    let presenter = SMHMainPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        beautifyUI()
        
        presenter.view = self
        presenter.updateExchangeRate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUIBasedOnInterfaceOrientation()
    }
    
    func setupUI() {
        self.title = "Base Currency"
        
        initLandscapeConstraints()
    }
    
}

// MARK: - Actions
extension SMHMainViewController {
    @IBAction func buttonClicked(_ sender: UIButton!) {
        if let title = sender.titleLabel?.text {
            presenter.handleButtonEvent(title: title)
        } else if sender.tag == Constants.mainControllerDeleteKeyTag {
            presenter.handleButtonEvent(title: Constants.deleteKeyTitle)
        }
    }
}

// MARK: - Update on exchange rate
extension SMHMainViewController {
    func updatedExchangeRate(fromCode: String, toCode: String, rate: String) {
        DispatchQueue.main.async {
            self.exchangeRateLeftLabel.text = "1 \(fromCode)"
            self.exchangeRateRightLabel.text = "\(rate) \(toCode)"
            
            self.topCurrencyCodeLabel.text = fromCode
            self.bottomCurrencyCodeLabel.text = toCode
        }
    }
}

// MARK: - Update on typing
extension SMHMainViewController {
    func updateCurrencyEntries(fromCurrency: String, toCurrency: String) {
        self.topCurrencyValueLabel.text = fromCurrency
        self.bottomCurrencyValueLabel.text = toCurrency
    }
}


// MARK: - Beautify UI
extension SMHMainViewController {
    func beautifyUI() {
        self.addRoundedCorners()
    }
    
    func addRoundedCorners() {
        self.roundCorners(for: self.topCurrencyLabelContainer, cornerRadius: self.containerRadius)
        self.roundCorners(for: self.bottomCurrencyLabelContainer, cornerRadius: self.containerRadius)
        self.roundCorners(for: self.topContainerView, cornerRadius: self.containerRadius)
        self.roundCorners(for: self.exchangeRateContainer, cornerRadius: self.containerRadius)
    }
    
    func roundCorners(for view: UIView, cornerRadius: CGFloat) {
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
    }
}


// MARK: - Constraints
extension SMHMainViewController {
    
    func initLandscapeConstraints() {
        self.landscapeTopContainerHeightConstraint = NSLayoutConstraint(item: self.topContainerView!, attribute: .height, relatedBy: .equal, toItem: self.mainStackView!, attribute: .height, multiplier: 0.35, constant: 0)
        self.landscapeBottomContainerHeightConstraint = NSLayoutConstraint(item: self.bottomContainerView!, attribute: .height, relatedBy: .equal, toItem: self.mainStackView!, attribute: .height, multiplier: 0.50, constant: 0)
        
        self.landscapeEntriesContainerHeightConstraint = NSLayoutConstraint(item: self.mainCurrencyContainer!, attribute: .height, relatedBy: .equal, toItem: self.currencyStackView!, attribute: .height, multiplier: 0.60, constant: 0)
        
        self.bottomFieldWidthConstraint = NSLayoutConstraint(item: self.bottomFieldContainer!, attribute: .width, relatedBy: .equal, toItem: self.topEntriesStackView!, attribute: .width, multiplier: 0.40, constant: 0)
        topFieldWidthConstraint = NSLayoutConstraint(item: self.topFieldContainer!, attribute: .width, relatedBy: .equal, toItem: self.topEntriesStackView!, attribute: .width, multiplier: 0.40, constant: 0)
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
        self.keypadStackView.spacing = 4
        self.topEntriesStackView.axis = .horizontal
        self.arrowImageView.image = UIImage(systemName: "arrow.turn.up.right")
        
        self.updateActiveContraints(inPortrait: false)
        self.view.layoutIfNeeded()
    }
    
    func toPortraitLaytout() {
        self.keypadStackView.spacing = 10
        self.topEntriesStackView.axis = .vertical
        self.arrowImageView.image = UIImage(systemName: "arrow.turn.left.down")
        
        self.updateActiveContraints(inPortrait: true)
        self.view.layoutIfNeeded()
    }
    
    func updateActiveContraints(inPortrait: Bool) {
        self.portraitTopContainerHeightConstraint.isActive = inPortrait
        self.portraitBottomContainerHeightConstraint.isActive = inPortrait
        self.portraitEntriesContainerHeightConstraint.isActive = inPortrait
        self.topFieldHeightConstraint.isActive = inPortrait
        self.bottomFieldHeightConstraint.isActive = inPortrait
        
        
        self.landscapeTopContainerHeightConstraint.isActive = !inPortrait
        self.landscapeBottomContainerHeightConstraint.isActive = !inPortrait
        self.landscapeEntriesContainerHeightConstraint.isActive = !inPortrait
        self.topFieldWidthConstraint.isActive = !inPortrait
        self.bottomFieldWidthConstraint.isActive = !inPortrait
    }
}
