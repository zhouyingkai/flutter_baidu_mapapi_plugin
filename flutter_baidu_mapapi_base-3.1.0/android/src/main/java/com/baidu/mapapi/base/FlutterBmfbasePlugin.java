package com.baidu.mapapi.base;

import java.util.HashMap;
import java.util.Map;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import com.baidu.mapapi.CoordType;
import com.baidu.mapapi.SDKInitializer;
import com.baidu.mapapi.VersionInfo;
import com.baidu.mapapi.common.BaiduMapSDKException;

/** FlutterBmfbasePlugin */
public class FlutterBmfbasePlugin implements FlutterPlugin, MethodCallHandler {

  private static final String METHOD_SET_API_KEY = "flutter_bmfbase/sdk/setApiKey";
  private static final String METHOD_GET_NATIVE_SDK_VERSION = "flutter_bmfbase/sdk/getNativeBaseVersion";
  private static final String METHOD_SET_PRIVACY_API_KEY = "flutter_bmfbase/sdk/setAgreePrivacy";

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final MethodChannel channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_bmfbase");
    channel.setMethodCallHandler(this);
    SDKInitializer.initialize(flutterPluginBinding.getApplicationContext());
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_bmfbase");
    channel.setMethodCallHandler(new FlutterBmfbasePlugin());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals(METHOD_GET_NATIVE_SDK_VERSION)) {
      Map<String, String> versionMap = new HashMap<>();
      versionMap.put("version", VersionInfo.getApiVersion());
      versionMap.put("platform", "Android");
      result.success(versionMap);
    } else if(call.method.equals(METHOD_SET_API_KEY)){
      if(call.hasArgument("BMF_COORD_TYPE")){
        int nCoordType = call.argument("BMF_COORD_TYPE");

        /**
         * flutter端的CoordType比android多了一个WGS-84，
         * 因此获取到的nCoordType要减1才能与android端匹配
         */
        nCoordType = nCoordType - 1;

        if(nCoordType >= 0 && CoordType.values().length > nCoordType){
          CoordType coordType = CoordType.values()[nCoordType];
          SDKInitializer.setCoordType(coordType);
        }

      }
    } else if (call.method.equals(METHOD_SET_PRIVACY_API_KEY)) {
      if (call.hasArgument("isAgree")) {
        boolean isAgree = call.argument("isAgree");
        if (BmfMapApplication.mContext != null) {
          try {
            SDKInitializer.setAgreePrivacy(BmfMapApplication.mContext, isAgree);
          } catch (BaiduMapSDKException e) {
            e.getMessage();
          }
        }
      }
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
  }
}
