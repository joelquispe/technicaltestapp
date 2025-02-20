package com.joelquispe.technicaltestapp.features.toast

import android.content.Context
import android.widget.Toast
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result

class ToastHandler(private val context: Context) {
    companion object {
        const val CHANNEL = "com.example/toast"
    }

    fun register(channel: MethodChannel) {
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "showToast" -> handleShowToast(call, result)
                else -> result.notImplemented()
            }
        }
    }

    private fun handleShowToast(call: MethodCall, result: Result) {
      val message = call.argument<String>("message")
      if (message != null) {
          showToast(message)
          result.success(null)
      } else {
          result.error(
              "INVALID_ARGUMENT",
              "Message is null or invalid",
              null
          )
      }
    }

    private fun showToast(message: String) {
        Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
    }
}