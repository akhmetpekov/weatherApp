//
//  MainView.swift
//  Weather App
//
//  Created by Erik on 17.10.2023.
//

import UIKit
import SnapKit

class MainView: UIViewController {
    
    private let weatherViewModel = WeatherViewModel()
    
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.isHidden = true
        return effectView
    }()
    
    private let cityName: UILabel = {
        let label = UILabel()
        label.text = "Your City"
        label.font = UIFont.systemFont(ofSize: Resources.Constants.fontSize, weight: .semibold)
        label.textColor = Resources.Colors.foregroundColor
        return label
    }()
    
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.weatherIcons.rainbow
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "0°C"
        label.font = UIFont.systemFont(ofSize: Resources.Constants.fontSize, weight: .semibold)
        label.textColor = Resources.Colors.foregroundColor
        return label
    }()
    
    private lazy var cityTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "City Name...",
            attributes: [NSAttributedString.Key.foregroundColor: Resources.Colors.textFieldBorderColor]
        )
        textField.backgroundColor = .clear
        textField.textColor = Resources.Colors.foregroundColor
        textField.autocapitalizationType = .sentences
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Resources.Colors.textFieldBorderColor.cgColor
        textField.setLeftPaddingPoints(15)
        textField.addTarget(self, action: #selector(cityTextFieldDidChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.configuration = .tinted()
        button.configuration?.image = Resources.Images.searchIcon
        button.configuration?.baseForegroundColor = Resources.Colors.foregroundColor
        button.configuration?.baseBackgroundColor = Resources.Colors.textFieldBorderColor
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .gray
        return indicator
    }()
    
    private let wrongCityAlert: UIAlertController = {
        let alert = UIAlertController(title: "Wrong City", message: "You Entered Wrong City Name", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        cityTextField.delegate = self
        setupUI()
        makeConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        cityTextField.layer.masksToBounds = false
        cityTextField.layer.cornerRadius = cityTextField.frame.height / 4
    }
    
    private func setupUI() {
        view.backgroundColor = Resources.Colors.backgroundColor
        view.addSubview(blurView)
        view.addSubview(cityName)
        view.addSubview(weatherIcon)
        view.addSubview(temperatureLabel)
        view.addSubview(cityTextField)
        view.addSubview(searchButton)
        view.addSubview(activityIndicator)
    }
    
    private func makeConstraints() {
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cityName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view.frame.height / 3)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(cityName.snp.bottom).offset(Resources.Constants.defaultPadding)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherIcon.snp.bottom).offset(Resources.Constants.defaultPadding)
        }
        
        cityTextField.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width / 2)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(temperatureLabel.snp.bottom).offset(Resources.Constants.defaultPadding * 2)
        }
        
        searchButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalTo(cityTextField.snp.trailing).offset(10)
            make.centerY.equalTo(cityTextField)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc private func cityTextFieldDidChanged(_ textField: UITextField) {
        if textField.text != "" {
            cityName.text = textField.text
        }
    }
    
    @objc private func searchButtonTapped() {
        guard let cityName = cityTextField.text else { return }
        cityTextField.text = ""
        showLoadingIndicator(true)
        weatherViewModel.fetchWeather(cityName: cityName) { [weak self] result in
            DispatchQueue.main.async {
                self?.showLoadingIndicator(false)
                
                switch result {
                case .success(let (temperature, id)):
                    self?.updateWeatherInfo(temperature: temperature, weatherID: id)
                case .failure(_):
                    self?.handleError()
                }
            }
        }
        dismissKeyboard()
    }
    
    private func showLoadingIndicator(_ show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        blurView.isHidden = !show
    }
    
    private func updateWeatherInfo(temperature: Double, weatherID: Int) {
        let formattedTemperature = Int(temperature.rounded())
        temperatureLabel.text = "\(formattedTemperature)°C"
        setWeatherIcon(for: weatherID)
    }
    
    private func setWeatherIcon(for weatherID: Int) {
        switch weatherID {
        case 200..<233:
            weatherIcon.image = Resources.Images.weatherIcons.thunderstorm
        case 300..<322:
            weatherIcon.image = Resources.Images.weatherIcons.drizzle
        case 500..<532:
            weatherIcon.image = Resources.Images.weatherIcons.rain
        case 600..<623:
            weatherIcon.image = Resources.Images.weatherIcons.snow
        case 700..<782:
            weatherIcon.image = Resources.Images.weatherIcons.atmosphere
        case 800:
            weatherIcon.image = Resources.Images.weatherIcons.clear
        case 801..<805:
            weatherIcon.image = Resources.Images.weatherIcons.clouds
        default:
            weatherIcon.image = Resources.Images.weatherIcons.rainbow
        }
    }
    
    private func handleError() {
        present(wrongCityAlert, animated: true)
        cityName.text = "Your City"
        weatherIcon.image = Resources.Images.weatherIcons.rainbow
        temperatureLabel.text = "0°C"
    }
}

extension MainView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.searchButtonTapped()
        return false
    }
}

