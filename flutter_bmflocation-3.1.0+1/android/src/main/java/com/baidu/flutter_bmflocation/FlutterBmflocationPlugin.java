package com.baidu.flutter_bmflocation;

import android.content.Context;

import androidx.annotation.NonNull;

import com.baidu.location.LocationClient;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

/** FlutterBmflocationPlugin */
public class FlutterBmflocationPlugin implements FlutterPlugin, MethodCallHandler {

  private static MethodChannel channel;

  private static Context mContext = null;

   /* 新版接口 */
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    if (null == flutterPluginBinding) {
      return;
    }
    if (null == mContext) {
      mContext = flutterPluginBinding.getApplicationContext();
    }
    initMethodChannel(flutterPluginBinding.getBinaryMessenger());
  }

  private void initMethodChannel(BinaryMessenger binaryMessenger) {
    if (null == binaryMessenger) {
      return;
    }

    channel = new MethodChannel(binaryMessenger, Constants.MethodChannelName.LOCATION_CHANNEL);
    channel.setMethodCallHandler(this);
    MethodChannelManager.getInstance().putLocationChannel(channel);
  }

   /* 旧版接口 */
  public static void registerWith(PluginRegistry.Registrar registrar) {
    if (null == registrar) {
      return;
    }
    if (null == mContext) {
      mContext = registrar.context();
    }
    initStaticMethodChannel(registrar.messenger());
  }

  private static void initStaticMethodChannel(BinaryMessenger binaryMessenger) {
    if (null == binaryMessenger) {
      return;
    }

    FlutterBmflocationPlugin flutterBmfPlugin = new FlutterBmflocationPlugin();

    channel = new MethodChannel(binaryMessenger, Constants.MethodChannelName.LOCATION_CHANNEL);
    channel.setMethodCallHandler(flutterBmfPlugin);
    MethodChannelManager.getInstance().putLocationChannel(channel);
  }


  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (mContext == null) {
      result.error("-1", "context is null", null);
    }

    if (call.method.equals(Constants.MethodID.LOCATION_SETAGREEPRIVACY)) {
      try {
        boolean isAgreePrivacy = (Boolean) call.arguments;
        LocationClient.setAgreePrivacy(isAgreePrivacy);
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
    
    HandlersFactory.getInstance(mContext).dispatchMethodHandler(mContext, call, result);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
