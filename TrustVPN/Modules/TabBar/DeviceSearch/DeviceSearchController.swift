import UIKit
import CoreBluetooth

class DeviceSearchController: UIViewController, CBCentralManagerDelegate {

    // MARK: - UI Elements
    private let circularProgressLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()
    private let arrowLayer = CAShapeLayer()
    private let proximityLabel = UILabel()
    private let searchButton = UIButton()
    private let descriptionLabel = UILabel()

    // Степень близости устройства (от 0 до 1)
    private var proximity: CGFloat = 0 {
        didSet {
            updateProximityUI()
        }
    }

    // Таймер для завершения поиска
    private var searchTimer: Timer?

    // Центр индикатора
    private var indicatorCenter: CGPoint!

    // Bluetooth Central Manager для поиска устройств
    private var centralManager: CBCentralManager!

    // Ограничение времени поиска (30 секунд)
    private let searchDuration: TimeInterval = 30.0

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Инициализация CoreBluetooth Central Manager
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = UIColor.black
        
        // Настройка полукруглого индикатора
        setupCircularProgress()
        
        // Настройка стрелки
        setupArrow()
        
        // Настройка лейбла для отображения близости
        setupProximityLabel()
        
        // Настройка текстового описания
        setupDescriptionLabel()
        
        // Настройка кнопки поиска устройства
        setupSearchButton()
    }

    private func setupCircularProgress() {
        let center = CGPoint(x: view.bounds.midX, y: view.bounds.midY - 100)
        indicatorCenter = center // Сохраняем центр для дальнейшего использования
        let radius: CGFloat = 120

        // Полукруг (дуга)
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: radius,
                                        startAngle: CGFloat.pi,
                                        endAngle: 0,
                                        clockwise: true)

        circularProgressLayer.path = circularPath.cgPath
        circularProgressLayer.lineWidth = 15
        circularProgressLayer.fillColor = UIColor.clear.cgColor
        circularProgressLayer.strokeColor = UIColor.black.cgColor
        circularProgressLayer.lineCap = .round

        // Настройка градиента
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.cyan.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.mask = circularProgressLayer

        view.layer.addSublayer(gradientLayer)
    }

    private func setupArrow() {
        let arrowPath = UIBezierPath()

        // Линия стрелки должна исходить от центра индикатора и иметь ограниченную длину
        arrowPath.move(to: CGPoint(x: 0, y: 0)) // Стартовая точка (центр вращения)
        arrowPath.addLine(to: CGPoint(x: 0, y: -90)) // Конечная точка стрелки (направление вверх)

        // Настройка стрелки
        arrowLayer.path = arrowPath.cgPath
        arrowLayer.lineWidth = 6
        arrowLayer.strokeColor = UIColor.white.cgColor
        arrowLayer.lineCap = .round

        // Позиционируем стрелку так, чтобы её центр совпадал с центром индикатора
        arrowLayer.position = indicatorCenter // Устанавливаем центр стрелки
        view.layer.addSublayer(arrowLayer)
    }

    private func setupProximityLabel() {
        proximityLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        proximityLabel.textColor = .white
        proximityLabel.textAlignment = .center
        proximityLabel.text = "00 μТ"
        proximityLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(proximityLabel)

        NSLayoutConstraint.activate([
            proximityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            proximityLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 20)
        ])
    }

    private func setupDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.textColor = .gray
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "When a device is detected, the indicator's values will change: the closer you get to the device, the higher the values."
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: proximityLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func setupSearchButton() {
        searchButton.setTitle("Start scanning", for: .normal)
        searchButton.backgroundColor = .systemBlue
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        searchButton.layer.cornerRadius = 25
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: #selector(startSearch), for: .touchUpInside)

        view.addSubview(searchButton)

        NSLayoutConstraint.activate([
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            searchButton.widthAnchor.constraint(equalToConstant: 200),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Update Proximity UI
    private func updateProximityUI() {
        // Обновляем значение лейбла
        let proximityValue = Int(proximity * 100)
        proximityLabel.text = "\(proximityValue) μТ"

        // Поворачиваем стрелку в зависимости от близости
        let minAngle = -CGFloat.pi / 2  // -90 градусов
        let maxAngle = CGFloat.pi / 2   // 90 градусов
        let angle = minAngle + (maxAngle - minAngle) * proximity // Линейное преобразование угла

        // Анимация поворота стрелки
        arrowLayer.setAffineTransform(CGAffineTransform(rotationAngle: angle))
    }

    // MARK: - Search Logic
    @objc private func startSearch() {
        // Останавливаем предыдущий поиск, если он был запущен
        stopSearch()

        // Проверка состояния Bluetooth
        if centralManager.state != .poweredOn {
            showBluetoothAlert()
            return
        }

        // Запускаем поиск устройств по Bluetooth
        centralManager.scanForPeripherals(withServices: nil, options: nil)

        // Таймер для остановки поиска через 30 секунд
        searchTimer = Timer.scheduledTimer(timeInterval: searchDuration, target: self, selector: #selector(stopSearch), userInfo: nil, repeats: false)
    }

    @objc private func stopSearch() {
        searchTimer?.invalidate()
        searchTimer = nil

        // Останавливаем сканирование Bluetooth
        centralManager.stopScan()

        // Когда поиск завершен, можно сбросить индикатор (опционально)
        updateProximity(to: 0.0)
    }

    // Функция для обновления уровня близости устройства
    private func updateProximity(to newValue: CGFloat) {
        proximity = max(0, min(1, newValue)) // Ограничиваем значение от 0 до 1
    }

    // MARK: - Bluetooth Delegate Methods
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            // Bluetooth включен, можно начать поиск
            print("Bluetooth включен и готов к поиску.")
        } else {
            // Bluetooth выключен или недоступен
            showBluetoothAlert()
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // Получаем значение RSSI и преобразуем его в диапазон от 0 до 1 для поворота стрелки
        let rssiValue = RSSI.intValue
        
        // Преобразуем значение RSSI в относительное значение (где -100 RSSI это минимальное значение, 0 это максимальное)
        let proximityValue = calculateProximityFromRSSI(rssiValue)
        
        // Обновляем индикатор в реальном времени
        updateProximity(to: proximityValue)
    }

    // Функция для преобразования RSSI в значение близости
    private func calculateProximityFromRSSI(_ rssi: Int) -> CGFloat {
        // Допустим, минимальное значение RSSI -100, максимальное 0
        let minRSSI: CGFloat = -100
        let maxRSSI: CGFloat = 0
        
        // Преобразуем значение RSSI в диапазон от 0 до 1
        let proximityValue = (CGFloat(rssi) - minRSSI) / (maxRSSI - minRSSI)
        return max(0, min(1, proximityValue)) // Ограничиваем значения от 0 до 1
    }

    // MARK: - Bluetooth Alert
    private func showBluetoothAlert() {
        let alert = UIAlertController(title: "Bluetooth is Off", message: "Please enable Bluetooth in Settings to continue scanning for devices.", preferredStyle: .alert)
        let openSettingsAction = UIAlertAction(title: "Open Settings", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(openSettingsAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
