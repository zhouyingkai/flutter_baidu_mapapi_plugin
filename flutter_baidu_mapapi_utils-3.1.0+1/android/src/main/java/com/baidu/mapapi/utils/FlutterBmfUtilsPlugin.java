package com.baidu.mapapi.utils;

import com.baidu.mapapi.utils.handlers.HandlersFactory;

import android.content.Context;
import android.util.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class FlutterBmfUtilsPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler {

    public static final String TAG = FlutterBmfUtilsPlugin.class.getSimpleName();
    private static MethodChannel sCommonChannel;
    private static MethodChannel sOpenChannel;
    private static MethodChannel sConverterChannel;

    private static Context mApplicationContext;

    public static Context getApplicationContext() {
        return mApplicationContext;
    }

    public static void registerWith(PluginRegistry.Registrar registrarFor) {
        sCommonChannel =
                new MethodChannel(registrarFor.messenger(), Constants.COMMON_METHOD_CHANNEL);
        sCommonChannel.setMethodCallHandler(new FlutterBmfUtilsPlugin());
        sOpenChannel = new MethodChannel(registrarFor.messenger(), Constants.OPEN_METHOD_CHANNEL);
        sOpenChannel.setMethodCallHandler(new FlutterBmfUtilsPlugin());
        sConverterChannel =
                new MethodChannel(registrarFor.messenger(), Constants.CONVERTER_METHOD_CHANNEL);
        sConverterChannel.setMethodCallHandler(new FlutterBmfUtilsPlugin());
    }

    @Override
    public void onAttachedToEngine(FlutterPluginBinding binding) {
        if (Env.DEBUG) {
            Log.d(TAG, "onAttachedToEngine enter");
        }

        mApplicationContext = binding.getApplicationContext();

        sCommonChannel =
                new MethodChannel(binding.getBinaryMessenger(), Constants.COMMON_METHOD_CHANNEL);
        sCommonChannel.setMethodCallHandler(new FlutterBmfUtilsPlugin());
        sOpenChannel =
                new MethodChannel(binding.getBinaryMessenger(), Constants.OPEN_METHOD_CHANNEL);
        sOpenChannel.setMethodCallHandler(new FlutterBmfUtilsPlugin());
        sConverterChannel =
                new MethodChannel(binding.getBinaryMessenger(), Constants.CONVERTER_METHOD_CHANNEL);
        sConverterChannel.setMethodCallHandler(new FlutterBmfUtilsPlugin());
    }

    @Override
    public void onDetachedFromEngine(FlutterPluginBinding binding) {

    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if (Env.DEBUG) {
            Log.d(TAG, "onMethodCall enter");
        }

        HandlersFactory.getInstance().dispatchMethodHandler(call, result);
    }
}