import FormX
import Foundation
import UIKit

let accessToken = "PUT_ACCESS_TOKEN_HERE"
let formID = "PUT_FORM_ID_HERE"


class CameraViewController: UIViewController, FormXCameraViewDelegate {
  let apiClient = FormXAPIClient(accessToken: accessToken)
  let cameraView = FormXCameraView()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.cameraView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(self.cameraView)
    self.view.backgroundColor = .black

    self.cameraView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    self.cameraView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    self.cameraView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    self.cameraView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    self.cameraView.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.cameraView.start()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    self.cameraView.stop()
  }
  
  private func showAlert(title: String, message: String? = nil) {
    let alert = UIAlertController(
      title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
      alert.dismiss(animated: true)
    })
    self.present(alert, animated: true)
  }
  
  private func showLoadingOverlay() -> UIViewController {
    let alert = UIAlertController(title: "Loading...", message: nil, preferredStyle: .alert)
    self.present(alert, animated: true)
    return alert
  }

  func formXCameraView(didFailed error: Error) {
    print(error)
    self.showAlert(title: "Error", message: error.localizedDescription)
  }

  func formXCameraView(didChangeState view: FormXCameraView) {
    // Capture the document image automatically when document is detected.
    if view.state == .ready {
      view.capture()
    }
  }

  func formXCameraView(didCapture images: [CGImage]) {
    guard let image = images.first.map({ UIImage(cgImage: $0) }) else {
      self.showAlert(title: "No document detected")
      return
    }
    guard let imageJpeg = image.jpegData(compressionQuality: 0.9) else {
      return
    }
    
    let loadingOverlay = self.showLoadingOverlay()
    // Extract fields from the captured image data.
    apiClient.extract(formId: formID, data: imageJpeg) {
      result, error in
      DispatchQueue.main.async {
        loadingOverlay.dismiss(animated: false)
        
        if let error = error {
          print(error)
          self.showAlert(title: "Error", message: error.localizedDescription)
          return
        }
        
        guard let items = result?.response.autoExtractionItems else {
          return
        }
        
        var lines: [String] = []
        
        for item in items {
          switch item {
          case .intValue(let field):
            lines.append("\(field.name): \(field.value)")
          case .stringValue(let field):
            lines.append("\(field.name): \(field.value)")
          case .purchaseInfoValue(let field):
            lines.append("purchase items:")
            for purchase in field.value {
              lines.append("  \(purchase.name): \(purchase.amount)")
            }
          default:
            print(item)
          }
        }
        self.showAlert(title: "Document fields", message: lines.joined(separator: "\n"))
      }
    }
  }

  func formXCameraView(didRequestClose view: FormXCameraView) {
    self.dismiss(animated: true)
  }
}
