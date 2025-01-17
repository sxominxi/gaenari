package com.example.gaenari.activity.result

import android.annotation.SuppressLint
import android.content.Context
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.gaenari.R
import com.example.gaenari.dto.request.SaveDataRequestDto
import com.example.gaenari.dto.response.ApiResponseDto
import com.example.gaenari.util.AccessToken
import com.example.gaenari.util.PreferencesUtil
import com.example.gaenari.util.Retrofit
import com.example.gaenari.util.TTSUtil
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class ResultActivity : AppCompatActivity() {
    private lateinit var requestDto: SaveDataRequestDto
    private lateinit var gifImageView: pl.droidsonroids.gif.GifImageView

    @SuppressLint("MissingInflatedId")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_result)

        // tts 알림
        TTSUtil.speak("달리기가 종료되었습니다. 결과를 확인해주세요")

        // TextViews 찾기
        val titleTextView = findViewById<TextView>(R.id.운동제목)
        val timeTextView = findViewById<TextView>(R.id.시간)
        val distanceTextView = findViewById<TextView>(R.id.거리)
        val heartRateTextView = findViewById<TextView>(R.id.심박수)
        val speedTextView = findViewById<TextView>(R.id.속도)
        gifImageView = findViewById<pl.droidsonroids.gif.GifImageView>(R.id.gifImageView)

        // 인텐트에서 데이터 가져오기
        requestDto = intent.getParcelableExtra("requestDto", SaveDataRequestDto::class.java)!!
        val programTitle = intent.getStringExtra("programTitle") ?: "운동 정보 없음"
        val totalTime = intent.getLongExtra("totalTime", 0)  // 밀리초를 받음
        val totalDistance = intent.getDoubleExtra("totalDistance", 0.0)
        val averageHeartRate = requestDto.heartrates.average
        val averageSpeed = requestDto.speeds.average
        updateGif(context = applicationContext)

        // 시간 포맷 변경
        val hours = totalTime / 3600000
        val minutes = (totalTime % 3600000) / 60000
        val seconds = ((totalTime % 3600000) % 60000) / 1000
        val formattedTime = String.format("%02d:%02d:%02d", hours, minutes, seconds)

        // TextViews에 값 설정
        titleTextView.text = programTitle
        timeTextView.text = formattedTime
        distanceTextView.text = String.format("%.2f km", totalDistance / 1000)
        heartRateTextView.text = String.format("%d bpm", averageHeartRate)
        speedTextView.text = String.format("%.2f km/h", averageSpeed)

        val saveBtn = findViewById<Button>(R.id.end_btn)
        saveBtn.setOnClickListener {
            saveExerciseRecordData()
            finish()
        }
    }

    @SuppressLint("ResourceType")
    fun updateGif(context: Context) {
        val prefs = PreferencesUtil.getEncryptedSharedPreferences(context)
        val petId = prefs.getLong("petId", 0)  // Default value as 0 if not found

        val resourceId = context.resources.getIdentifier("lay${petId}", "raw", context.packageName)

        // resourceId가 0이 아니면 리소스가 존재하는 것이므로 이미지를 설정하고, 0이면 기본 이미지를 설정
        if (resourceId != 0) {
            gifImageView.setImageResource(resourceId)
        } else {
            // 예를 들어 기본 이미지로 설정
            gifImageView.setImageResource(R.raw.doghome)
        }
    }

    /**
     * 운동 기록 저장 API 호출 및 결과 확인
     */
    private fun saveExerciseRecordData() {
        Log.d("Check", "Exercise Record Data : $requestDto")
        requestDto.record.distance /= 1000
        val call = Retrofit.getApiService()
            .saveRunningData(AccessToken.getInstance().accessToken, requestDto)

        call.enqueue(object : Callback<ApiResponseDto<String>> {
            override fun onResponse(
                call: Call<ApiResponseDto<String>>,
                response: Response<ApiResponseDto<String>>
            ) {
                if (response.body()?.status == "SUCCESS")
                    Toast.makeText(
                        this@ResultActivity,
                        "운동 기록 전송 성공",
                        Toast.LENGTH_SHORT
                    ).show()
                else
                    Toast.makeText(
                        this@ResultActivity,
                        response.body()?.message,
                        Toast.LENGTH_SHORT
                    ).show()
            }

            override fun onFailure(call: Call<ApiResponseDto<String>>, t: Throwable) {
                Toast.makeText(
                    this@ResultActivity,
                    "API 연결 실패.",
                    Toast.LENGTH_SHORT
                ).show()
            }
        })
    }

    override fun onDestroy() {
        super.onDestroy()
    }
}