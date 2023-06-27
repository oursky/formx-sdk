package com.oursky.formx_demo

import ai.formx.mobile.sdk.FormXAPIClient
import ai.formx.mobile.sdk.FormXAutoExtractionIntItem
import ai.formx.mobile.sdk.FormXAutoExtractionPurchaseInfoItem
import ai.formx.mobile.sdk.FormXAutoExtractionStringItem
import ai.formx.mobile.sdk.camera.FormXCameraView
import ai.formx.mobile.sdk.camera.FormXCameraViewListener
import ai.formx.mobile.sdk.camera.FormXCameraViewState
import android.graphics.Bitmap
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.app.AlertDialog
import androidx.fragment.app.Fragment
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.oursky.formx_demo.databinding.FragmentCameraBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.io.ByteArrayOutputStream

const val accessToken = "PUT_ACCESS_TOKEN_HERE"
const val formID = "PUT_FORM_ID_HERE"

class CameraFragment : Fragment() {
    val apiClient = FormXAPIClient(accessToken)

    private lateinit var binding: FragmentCameraBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentCameraBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        binding.cameraView.listener = object: FormXCameraViewListener {
            override fun onCaptureImage(images: List<Bitmap>) {
                val image = images.firstOrNull() ?: return

                val bytes = ByteArrayOutputStream()
                image.compress(Bitmap.CompressFormat.JPEG, 90, bytes)

                val loading = AlertDialog.Builder(requireContext())
                    .setMessage("Loading...")
                    .setCancelable(false)
                    .show()

                lifecycleScope.launch {
                    val result = runCatching {
                         apiClient.extract(formID, bytes.toByteArray()).first()
                    }
                    withContext(Dispatchers.Main) {
                        loading.dismiss()
                        result
                            .onFailure {
                                AlertDialog.Builder(requireContext())
                                    .setTitle("Error")
                                    .setMessage(it.localizedMessage)
                                    .setPositiveButton("OK") { dialog, _ ->
                                        dialog.dismiss()
                                    }
                                    .show()
                            }
                            .onSuccess {
                                val lines = mutableListOf<String>()
                                for (item in it.autoExtractionItems) {
                                    when (val field = item.value) {
                                        is FormXAutoExtractionIntItem ->
                                            lines += "${field.name} ${field.value}"
                                        is FormXAutoExtractionStringItem ->
                                            lines += "${field.name} ${field.value}"
                                        is FormXAutoExtractionPurchaseInfoItem -> {
                                            lines += "purchase items"
                                            for (purchase in field.value) {
                                                lines += "  ${purchase.name}: ${purchase.amount}"
                                            }
                                        }
                                    }
                                }
                                AlertDialog.Builder(requireContext())
                                    .setTitle("Document fields")
                                    .setMessage(lines.joinToString("\n"))
                                    .setPositiveButton("OK") { dialog, _ ->
                                        dialog.dismiss()
                                    }
                                    .show()
                            }
                    }
                }
            }

            override fun onClose() {
                findNavController().navigate(R.id.action_dismiss_camera)
            }

            override fun onError(error: Throwable) {
                AlertDialog.Builder(requireContext())
                    .setTitle("Error")
                    .setMessage(error.localizedMessage)
                    .setPositiveButton("OK") { dialog, _ ->
                        dialog.dismiss()
                    }
                    .show()
            }

            override fun onStateChange(view: FormXCameraView) {
                if (view.state == FormXCameraViewState.READY) {
                    view.capture()
                }
            }
        }
    }
}