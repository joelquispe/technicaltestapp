//
//  ToastHandler.swift
//  Runner
//
//  Created by joel on 20/02/25.
//

import UIKit
import Flutter

class ToastHandler {
    static let CHANNEL = "com.example/toast"

    static func register(with channel: FlutterMethodChannel, in view: UIView) {
        channel.setMethodCallHandler { call, result in
            if call.method == "showToast" {
                guard let args = call.arguments as? [String: String],
                      let message = args["message"] else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Message is null", details: nil))
                    return
                }
                showCustomToast(message: message, in: view)
                result(nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
}

extension ToastHandler{
  private static func showCustomToast(message: String, in view: UIView) {
      let toastView = UIView()
      toastView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
      toastView.layer.cornerRadius = 8
      toastView.clipsToBounds = true

      let label = UILabel()
      label.text = message
      label.textColor = .white
      label.font = .systemFont(ofSize: 14)
      label.textAlignment = .center
      label.numberOfLines = 1

      toastView.addSubview(label)
      label.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
          label.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 8),
          label.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -8),
          label.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 12),
          label.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -12)
      ])

      view.addSubview(toastView)
      toastView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
          toastView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          toastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
          toastView.widthAnchor.constraint(lessThanOrEqualToConstant: 300)
      ])

      toastView.alpha = 0
      UIView.animate(withDuration: 0.3) {
          toastView.alpha = 1
      }

      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          UIView.animate(withDuration: 0.3, animations: {
              toastView.alpha = 0
          }) { _ in
              toastView.removeFromSuperview()
          }
      }
  }
}
