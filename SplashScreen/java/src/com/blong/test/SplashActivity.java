package com.blong.test;

import android.app.Activity;
import android.content.Intent;
import android.content.res.Resources;
import android.os.Bundle;
import android.os.Build;
import android.view.WindowManager;
import android.view.MotionEvent;
import android.view.Window;
import android.view.ViewGroup;
import android.view.Gravity;
import android.widget.LinearLayout;
import android.widget.ImageView;
import android.widget.Toast;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.BitmapDrawable;
import android.util.Log;
import java.io.InputStream;
import java.io.FileInputStream;
import java.util.Scanner;

public class SplashActivity extends Activity
{
  private boolean active = true;

  private int elapsed = 0;

  private static int SPLASH_TIME_OUT = 3000;

  private static int SPLASH_INTERVAL = 100;

  int get_resource_id(String resourceName, String resourceType)
  {
    return this.getResources().getIdentifier(resourceName, resourceType,
      this.getPackageName()) ;
  }

  int get_string_id(String resourceName)
  {
    return get_resource_id(resourceName, "string");
  }

  int get_drawable_id(String resourceName)
  {
    return get_resource_id(resourceName, "drawable");
  }

  int get_layout_id(String resourceName)
  {
    return get_resource_id(resourceName, "layout");
  }

  protected void onCreate(Bundle savedInstanceState)
  {
    super.onCreate(savedInstanceState);

    requestWindowFeature(Window.FEATURE_NO_TITLE);
    getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);

  /*
    //Make a linear layout that fills the screen and vertically centres child views
    LinearLayout mainLayout = new LinearLayout(this);
    mainLayout.setOrientation(LinearLayout.VERTICAL);
    mainLayout.setLayoutParams(new LinearLayout.LayoutParams(
      LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT));
    mainLayout.setGravity(Gravity.CENTER_HORIZONTAL | Gravity.CENTER_VERTICAL);

    //Load an image
    ImageView image = new ImageView(this);
    image.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
    image.setLayoutParams(new ViewGroup.LayoutParams(
        ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));


    //Load splash screeen image from the assets directory
    try
    {
      InputStream stream = this.getAssets().open("splash.png");
      Bitmap bitmap = BitmapFactory.decodeStream(stream);
      bitmap.setDensity(Bitmap.DENSITY_NONE);
      Drawable drawable = new BitmapDrawable(Resources.getSystem(), bitmap);
    }
    catch (java.io.IOException e)
    {
      Log.d("Splash", e.toString());
    }

    //Load splash screen image from the compiled resources
    image.setImageResource(get_drawable_id("splash"));

    mainLayout.addView(image);
    setContentView(mainLayout);
  */

    setContentView(get_layout_id("splash_activity"));

    new Thread(new Runnable()
    {
      @Override
      public void run() {
        try
        {
          int elapsed = 0;
          while (SplashActivity.this.active && (elapsed < SPLASH_TIME_OUT))
          {
            Thread.sleep(SPLASH_INTERVAL);
            if (SplashActivity.this.active)
              elapsed += SPLASH_INTERVAL;
          }
        }
        catch (InterruptedException e)
        {
          // Nothing
        }
        finally
        {
          finish();
          if (SplashActivity.this.active)
          {
            Intent launchIntent = new Intent();
            Log.d("Splash", "Launching the main activity now");
            launchIntent.setClassName(SplashActivity.this, "com.embarcadero.firemonkey.FMXNativeActivity");
            startActivity(launchIntent);
          }
        }
      }
    }).start();
  }

  protected void onResume()
  {
    super.onResume();

    //Check OS is an appropriate version
    if ((Build.VERSION.SDK_INT == 10) ||  //GINGERBREAD_MR1
        (Build.VERSION.SDK_INT == 15) ||  //ICE_CREAM_SANDWICH_MR1
        (Build.VERSION.SDK_INT == 16) ||  //JELLY_BEAN
        (Build.VERSION.SDK_INT == 17) ||  //JELLY_BEAN_MR1
        (Build.VERSION.SDK_INT >= 18))    //JELLY_BEAN_MR2 or later
    {
      //Delphi FireMonkey supports you
      Log.d("Splash", "Supported OS version");
    }
    else
    {
      //Unsupported OS version
      Log.e("Splash", "Unsupported OS version :o(");
      active = false;
      Toast.makeText(this, get_string_id("unsupported_os"),
        Toast.LENGTH_LONG).show();
      return;
    }
    try
    {
      //Check for NEON
      FileInputStream fis = new FileInputStream("/proc/cpuinfo");
      //Scan the whole file in as a delimted token, where the delimiter
      //isn't there, so we just have one token: the file content
      java.util.Scanner s = new java.util.Scanner(fis).useDelimiter("\\A");
      String cpuinfo = s.hasNext() ? s.next() : "";
      if (cpuinfo.contains("ARMv7"))
      {
        Log.d("Splash", "ARMv7 CPU detected");
      }
      else
      {
        Log.e("Splash", "ARMv7 CPU not detected!!! :o(");
        active = false;
        Toast.makeText(this, get_string_id("cpu_not_arm7"),
          Toast.LENGTH_LONG).show();
        return;
      }
      if (cpuinfo.contains("neon"))
      {
        Log.d("Splash", "NEON instructions supported");
      }
      else
      {
        Log.e("Splash", "NEON instructions not supported :o(");
        Toast.makeText(this, get_string_id("no_neon_support"),
          Toast.LENGTH_LONG).show();
        active = false;
      }
    }
    catch (java.io.IOException e)
    {
      Log.d("Splash", e.toString());
    }
  }

  protected void onDestroy()
  {
    Log.d("Splash", "onDestroy");
    this.active = false;
    super.onDestroy();
  }

  public boolean onTouchEvent(MotionEvent anEvent)
  {
    if (anEvent.getAction() == MotionEvent.ACTION_DOWN)
    {
      elapsed = SPLASH_TIME_OUT;
      return true;
    }
    return false;
  }
}