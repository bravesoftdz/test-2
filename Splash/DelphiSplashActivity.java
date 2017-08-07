package com.chanwooapp.delphisplash;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

public class DelphiSplashActivity extends Activity {

	private int getSplash(String resourceName, String resourceType)
	{
	  return this.getResources().getIdentifier(resourceName, resourceType, this.getPackageName()) ;
	}

	private void loadMainIntent()
	{
		Intent launchIntent = new Intent();
		// 델파이 메인 Intent 클래스를 로딩합니다.
		launchIntent.setClassName(DelphiSplashActivity.this, "com.embarcadero.firemonkey.FMXNativeActivity");
		startActivity(launchIntent);
	}

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		// 리소스 파일에서 뷰형태를 읽어서 화면을 불러옵니다.
	   	setContentView(getSplash("delphisplash", "layout"));
		final int welcomeScreenDisplay = 1000;
		Thread welcomeThread = new Thread() {
  	               int wait = 0;

			@Override
			public void run() {
				try {
					super.run();
					// 약1초대기후
					while (wait < welcomeScreenDisplay) {
						sleep(100);
						wait += 100;
					}
				} catch (Exception e) {
					System.out.println("EXc=" + e);
				} finally {
					// 델파이메인화면 (intent)을 불러옵니다.
					loadMainIntent();
					// 쓰래드를 종료합니다.
					finish();
				}
			}
		};
		welcomeThread.start();
	}
}
