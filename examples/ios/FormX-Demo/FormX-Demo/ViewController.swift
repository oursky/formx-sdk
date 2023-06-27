import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func onButtonTap(_ sender: Any) {
    let camera = CameraViewController()
    camera.modalPresentationStyle = .fullScreen
    self.present(camera, animated: true)
  }
}
