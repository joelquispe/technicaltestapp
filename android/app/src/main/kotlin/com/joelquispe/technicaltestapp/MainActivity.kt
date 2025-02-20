package com.joelquispe.technicaltestapp

import com.joelquispe.technicaltestapp.features.toast.ToastHandler

import android.util.Log
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle

import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall

class MainActivity: FlutterActivity(){
  private val CHANNEL = "com.example/toast"
  override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setupMethodChannel()
        
    }

    private fun setupMethodChannel() {
        flutterEngine?.let { engine ->
          val toastChannel = MethodChannel(engine.dartExecutor.binaryMessenger, ToastHandler.CHANNEL)
          ToastHandler(this).register(toastChannel)
        } ?: run {
            Log.e("MainActivity", "FlutterEngine is null")
        }
    }
}
